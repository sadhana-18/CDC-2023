import functions as f
import csv
import time

token = f.get_token()

fields = ["Song", "Year", "ID", "Artists", "Duration", "Popularity", "Danceability", "Speechiness", "Valence"]
rows = []

#Collecting song names/years
with open("CDC.csv") as input:
    csvreader = csv.reader(input)
    for row in csvreader:
        for i in range(1, len(row)):
            rows.append([row[i], row[0]])

#Collecting the rest of the variables
for i in range(600,1200):
    song = rows[i][0]
    result = f.search_for_song(token, song)
    if result != None:
        if "id" in result:
            audio_features = f.get_audio_features(token, result["id"])
            if audio_features != None:
                rows[i] = rows[i] + [result["id"], result["artists"][0]["name"], result["duration_ms"], result["popularity"], 
                                     audio_features["danceability"], audio_features["speechiness"], audio_features["valence"]]
        
with open("spotify2.csv", 'w') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(fields)
    csvwriter.writerows(rows[600:1200])