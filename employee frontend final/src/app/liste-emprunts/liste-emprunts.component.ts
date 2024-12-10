import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-liste-emprunts',
  templateUrl: './liste-emprunts.component.html',
  styleUrls: ['./liste-emprunts.component.css']
})
export class ListeEmpruntsComponent implements OnInit {
  emprunts: any[] = [];  // Déclaration de la variable emprunts

  constructor() { }

  ngOnInit(): void {
    // Simuler la récupération des emprunts depuis un service ou une source de données
    setTimeout(() => {
      this.emprunts = [
        {
          id: 1,
          nomLivre: 'Le Petit Prince',
          dateAcquisition: '2024-01-15',
          dateRetour: '2024-02-15',
          etat: 'Retourné'
        },
        {
          id: 2,
          nomLivre: '1984',
          dateAcquisition: '2024-03-10',
          dateRetour: '2024-04-10',
          etat: 'Empreinté'
        }
      ];
    }, 2000);  // Simuler un délai de chargement
  }
}
