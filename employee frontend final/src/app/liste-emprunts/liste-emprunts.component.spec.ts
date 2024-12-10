import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListeEmpruntsComponent } from './liste-emprunts.component';

describe('ListeEmpruntsComponent', () => {
  let component: ListeEmpruntsComponent;
  let fixture: ComponentFixture<ListeEmpruntsComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListeEmpruntsComponent]
    });
    fixture = TestBed.createComponent(ListeEmpruntsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
