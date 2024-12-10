import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { BookService } from '../book.service';
import { Book } from '../book.model';

@Component({
  selector: 'app-edit-book',
  templateUrl: './edit-book.component.html',
  styleUrls: ['./edit-book.component.css']
})
export class EditBookComponent implements OnInit {
  bookForm: FormGroup;
  bookId: number = 0;

  constructor(
    private fb: FormBuilder,
    private bookService: BookService,
    private route: ActivatedRoute,
    private router: Router
  ) {
    this.bookForm = this.fb.group({
      name: ['', Validators.required],
      type: ['', Validators.required],
      auteur: ['', Validators.required],
      availability: ['Oui', Validators.required],
      editeur: ['', Validators.required],
      dateDePublication: ['', Validators.required],
      description: [''],
      photo: [''] // Champ pour stocker la photo téléchargée
    });
  }

  ngOnInit(): void {
    this.bookId = +this.route.snapshot.paramMap.get('id')!;
    this.loadBook();
  }

  loadBook() {
    this.bookService.getBookById(this.bookId).subscribe(book => {
      // Préremplir le formulaire avec les données existantes du livre
      this.bookForm.patchValue(book);
    });
  }

  onSubmit() {
    if (this.bookForm.valid) {
      // Si une photo a été ajoutée, la traiter avant d'envoyer les données
      const formValue = this.bookForm.value;
      if (formValue.photo instanceof File) {
        this.convertFileToBase64(formValue.photo).then(base64Image => {
          // Ajouter l'image en base64 dans le formulaire avant de soumettre
          formValue.photo = base64Image;
          this.updateBook(formValue);
        });
      } else {
        this.updateBook(formValue);
      }
    }
  }

  // Mettre à jour le livre avec les données du formulaire
  updateBook(bookData: any) {
    this.bookService.updateBook(this.bookId, bookData).subscribe(() => {
      alert('Livre modifié avec succès.');
      this.router.navigate(['/books']); // Redirection vers la liste des livres
    }, error => {
      console.error('Erreur lors de la modification du livre:', error);
      alert('Erreur lors de la modification du livre.');
    });
  }

  // Convertir le fichier image en base64
  convertFileToBase64(file: File): Promise<string> {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onloadend = () => {
        resolve(reader.result as string);
      };
      reader.onerror = reject;
      reader.readAsDataURL(file);
    });
  }

  // Gestion du changement de fichier pour l'upload de la photo
  onFileChange(event: any): void {
    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onloadend = () => {
      const base64String = reader.result as string;
      // Enlever le préfixe si nécessaire
      const base64Data = base64String.split(',')[1]; // Récupère la partie base64 pure
      this.bookForm.patchValue({ photo: base64Data });  // Mettez à jour le formulaire
    };

    if (file) {
      reader.readAsDataURL(file);
    }
  }

}
