CREATE TABLE utilisateur(
   Id_utilisateur SERIAL,
   nom VARCHAR(50) ,
   prenom VARCHAR(50) ,
   e_mail VARCHAR(50) ,
   numeroTelephone SMALLINT,
   Photo image,
   statutActif BOOLEAN,
   canalCommunication VARCHAR(50) ,
   administrateur BOOLEAN,
   motDePasse VARCHAR(50) ,
   PRIMARY KEY(Id_utilisateur)
);

CREATE TABLE employe(
   Id_employe SERIAL,
   role VARCHAR(50) ,
   dureeContract VARCHAR(50) ,
   Id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_employe),
   UNIQUE(Id_utilisateur),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

CREATE TABLE stagiaire(
   Id_stagiaire SERIAL,
   Id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_stagiaire),
   UNIQUE(Id_utilisateur),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

CREATE TABLE Trajet(
   Id_Trajet SERIAL,
   adresseDepard VARCHAR(50) ,
   heureDepard TIME,
   adresseArrivee VARCHAR(50) ,
   vehiculeUtilise VARCHAR(50) ,
   prixTrajet VARCHAR(50) ,
   description VARCHAR(250) ,
   Id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_Trajet),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

CREATE TABLE type_carburant(
   Id_type_carburant SERIAL,
   carburant VARCHAR(50) ,
   prixCarburant NUMERIC(5,2)  ,
   PRIMARY KEY(Id_type_carburant)
);

CREATE TABLE typeVehicule(
   Id_typeVehicule SERIAL,
   vehicule VARCHAR(50) ,
   PRIMARY KEY(Id_typeVehicule)
);

CREATE TABLE formateur(
   Id_formateur SERIAL,
   Id_employe INTEGER NOT NULL,
   PRIMARY KEY(Id_formateur),
   UNIQUE(Id_employe),
   FOREIGN KEY(Id_employe) REFERENCES employe(Id_employe)
);

CREATE TABLE formation(
   Id_formation SERIAL,
   nomFormation VARCHAR(50) ,
   Id_formateur INTEGER NOT NULL,
   PRIMARY KEY(Id_formation),
   FOREIGN KEY(Id_formateur) REFERENCES formateur(Id_formateur)
);

CREATE TABLE centreFormation(
   Id_centreFormation SERIAL,
   nom VARCHAR(50) ,
   horaireOuverture TIME,
   adresse VARCHAR(50) ,
   PRIMARY KEY(Id_centreFormation)
);

CREATE TABLE notification(
   Id_notification SERIAL,
   message VARCHAR(400) ,
   Id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_notification),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

CREATE TABLE estimationPrix(
   Id_estimationPrix SERIAL,
   conso_100 NUMERIC(5,2)  ,
   Id_type_carburant INTEGER NOT NULL,
   Id_typeVehicule INTEGER NOT NULL,
   PRIMARY KEY(Id_estimationPrix),
   FOREIGN KEY(Id_type_carburant) REFERENCES type_carburant(Id_type_carburant),
   FOREIGN KEY(Id_typeVehicule) REFERENCES typeVehicule(Id_typeVehicule)
);

CREATE TABLE ponctuel(
   Id_ponctuel SERIAL,
   jour TIMESTAMP,
   Id_Trajet INTEGER NOT NULL,
   PRIMARY KEY(Id_ponctuel),
   UNIQUE(Id_Trajet),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE regulier(
   Id_regulier SERIAL,
   DateDisponibilité DATE,
   joursTrajet VARCHAR(50) ,
   joursSemaine VARCHAR(50) ,
   Id_Trajet INTEGER NOT NULL,
   PRIMARY KEY(Id_regulier),
   UNIQUE(Id_Trajet),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE commentaire(
   Id_commentaire SERIAL,
   personneEmettrice VARCHAR(50) ,
   personne_concernee VARCHAR(50) ,
   commentaire VARCHAR(50) ,
   Id_Trajet INTEGER NOT NULL,
   PRIMARY KEY(Id_commentaire),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);

CREATE TABLE SessionFormation(
   Id_SessionFormation SERIAL,
   dateDebut DATE,
   dateFin DATE,
   Id_formation INTEGER NOT NULL,
   PRIMARY KEY(Id_SessionFormation),
   FOREIGN KEY(Id_formation) REFERENCES formation(Id_formation)
);

CREATE TABLE Vehicule(
   Id_Vehicule SERIAL,
   modele VARCHAR(50) ,
   nbPlaceDispo SMALLINT,
   Id_estimationPrix INTEGER NOT NULL,
   Id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(Id_Vehicule),
   FOREIGN KEY(Id_estimationPrix) REFERENCES estimationPrix(Id_estimationPrix),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

CREATE TABLE participe(
   Id_stagiaire INTEGER,
   Id_SessionFormation INTEGER,
   PRIMARY KEY(Id_stagiaire, Id_SessionFormation),
   FOREIGN KEY(Id_stagiaire) REFERENCES stagiaire(Id_stagiaire),
   FOREIGN KEY(Id_SessionFormation) REFERENCES SessionFormation(Id_SessionFormation)
);

CREATE TABLE dispense(
   Id_SessionFormation INTEGER,
   Id_formateur INTEGER,
   PRIMARY KEY(Id_SessionFormation, Id_formateur),
   FOREIGN KEY(Id_SessionFormation) REFERENCES SessionFormation(Id_SessionFormation),
   FOREIGN KEY(Id_formateur) REFERENCES formateur(Id_formateur)
);

CREATE TABLE demande(
   Id_utilisateur INTEGER,
   Id_Trajet INTEGER,
   acceptation BOOLEAN,
   PRIMARY KEY(Id_utilisateur, Id_Trajet),
   FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur),
   FOREIGN KEY(Id_Trajet) REFERENCES Trajet(Id_Trajet)
);