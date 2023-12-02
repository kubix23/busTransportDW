CREATE DATABASE BusTransportDW
GO
USE BusTransportDW
GO
CREATE TABLE Data
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Dzien INTEGER NOT NULL,
	Miesiac Varchar(15) CHECK (Miesiac IN ('Styczeñ','Luty','Marzec','Kwiecieñ','Maj','Czerwiec',
											'Lipiec','Sierpieñ','Wrzesieñ','PaŸdziernik','Listopad','Grudzieñ')),
	Rok INTEGER NOT NULL,
	Dzien_tygodnia VARCHAR(12) CHECK (Dzien_tygodnia IN ('Poniedzia³ek','Wtorek','Œroda','Czwartek','Pi¹tek','Sobota','Niedziela')),
)
CREATE TABLE Czas
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Godzina INTEGER NOT NULL,
	Minuta INTEGER NOT NULL,
)
GO
CREATE TABLE Autobus
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Data_zakupu INTEGER NOT NULL FOREIGN KEY REFERENCES Data,
	Numer_rejestracyjny VARCHAR(10) NOT NULL,
)	
CREATE TABLE Punkt_trasy
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Miasto VARCHAR(20) NOT NULL,
	Ulica VARCHAR(20) NOT NULL,
	Nr_ulicy VARCHAR(8) NOT NULL,
)
CREATE TABLE Kierowca
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Imie_nazwisko VARCHAR(80) NOT NULL,
	Data_zatrudnienia INTEGER NOT NULL FOREIGN KEY REFERENCES Data,
	Numer_dowodu VARCHAR(15) NOT NULL,
	Miasto VARCHAR(50) NOT NULL,
	Aktywny VARCHAR(3) NOT NULL CHECK (Aktywny IN ('Tak','Nie')),
)
GO
CREATE TABLE Kurs
(
	Id INTEGER IDENTITY(0,1) PRIMARY KEY,
	Data_rozpoczecia_kursu INTEGER NOT NULL FOREIGN KEY REFERENCES Data,
	Czas_rozpoczecia_kursu INTEGER NOT NULL FOREIGN KEY REFERENCES Czas,
	Data_zakonczenia_kursu INTEGER NOT NULL FOREIGN KEY REFERENCES Data,
	Czas_zakonczenia_kursu INTEGER NOT NULL FOREIGN KEY REFERENCES Czas,
	Autobus INTEGER NOT NULL FOREIGN KEY REFERENCES Autobus,
	Kierowca INTEGER NOT NULL FOREIGN KEY REFERENCES Kierowca,
	Punkt_poczatkowy INTEGER NOT NULL FOREIGN KEY REFERENCES Punkt_trasy,
	Punkt_koncowy INTEGER NOT NULL FOREIGN KEY REFERENCES Punkt_trasy,
	Dlugosc_trasy INTEGER NOT NULL,
	Czas_trwania_kursu INTEGER NOT NULL,
	SLKDM INTEGER NOT NULL,
	Stawka_godzinowa INTEGER NOT NULL,
)
GO
CREATE TABLE Skasowanie
(
    Kurs INTEGER FOREIGN KEY REFERENCES Kurs,
	Data INTEGER FOREIGN KEY REFERENCES Data,
	Czas INTEGER FOREIGN KEY REFERENCES Czas,
	Numer_biletu INTEGER,
	Kwota FLOAT NOT NULL,
	Ilosc_miejsc INTEGER NOT NULL,
	Data_sprzedazy INTEGER NOT NULL FOREIGN KEY REFERENCES Data,
	PRIMARY KEY (Kurs,Data,Czas,Numer_biletu)
)