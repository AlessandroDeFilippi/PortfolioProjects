# Analisi della popolazione per quartiere, fascia d'età e nazionalità (Milano)

Questo progetto mostra un processo completo di **pulizia e aggregazione dati** a partire da un file CSV contenente la distribuzione della popolazione milanese per quartiere, anno, età, genere e cittadinanza.

## Obiettivo

Creare un dataset semplificato e aggregato, **pronto per Tableau**, che permetta di visualizzare:

- L'evoluzione della popolazione nel tempo
- Le **fasce d’età principali**:
  - 0–14 (Infanzia e adolescenza)
  - 15–24 (Giovani)
  - 25–44 (Giovani adulti e famiglie)
  - 45–64 (Adulti maturi)
  - 65–84 (Anziani attivi)
  - 85+ (Grandi anziani)
- La distinzione tra **italiani e stranieri**
- Il dettaglio per **quartiere (Nil)**

## File principali

- `popolazione.csv` → Dati grezzi di partenza
- `trasforma_popolazione.py` → Script Python per trasformare e aggregare i dati
- `popolazione_aggregata_per_tableau.csv` → Dataset finale pronto per Tableau

## Dipendenze

- Python 3.x
- Pandas
