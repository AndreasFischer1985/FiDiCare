###########################################################################################
# Author: 	Dr. Andreas Fischer
# Date:		15.11.2022 
# Update: 	19.07.2024
# Description:	R-Syntax zur Generierung einer HTML-Tabelle für das digitale Pflegeportal
		auf Basis der Datei "Überblick Digitalisierung Pflege.xlsx".
###########################################################################################

install.packages("readxl")
path="myPath"
while(!file.exists(path)) path=utils::choose.dir("","Wähle Ordner in dem die xlsx des RZBB liegt")
setwd(path); 
file= # spezifiziere xlsx-Files mit den Befragungsdaten 
beschreibungen=readxl::read_xlsx(
	"Überblick Digitalisierung Pflege.xlsx", sheet=2)
	#gsub("^[~][$]","",list.files(pattern="[.]xlsx$")[1]),sheet=2)

beschreibungen=beschreibungen[rowSums(is.na(beschreibungen[,1:4]))<4,] # exclude missing entries

url=gsub("[<>]","",beschreibungen[[2]])
anwendung=gsub("[<>]","",beschreibungen[["Anwendung"]])
kurzbeschreibung=gsub("[<>]","",beschreibungen[["Kurzbeschreibung von Angebotswebsite"]])
feld=gsub("[<>]","",beschreibungen[["Feld"]])
feldA=gsub("/.*","",feld)
feldB=gsub(".*/","",feld)

table(feldA)
table(feldB)
sum(table(feldA))

rows=sapply(1:length(anwendung), function(id) paste0(
"<tr class=\"row\">\n",
"<td><strong>",id,"</strong></td>\n",
"<td><a href=\"",url[id],"\">",anwendung[id],"</a>&nbsp;</td>\n",
"<td>",feldA[id],"&nbsp;</td>\n",
"<td>",feldB[id],"&nbsp;</td>\n",
"<td>",kurzbeschreibung[id],"</td>\n",
"</tr>\n"
));

rows=c(
	"<tr class=\"filter\">\n",
	"<td></td>\n",
	"<td><input type=\"text\" id=\"filter\" onkeyup=\"filterTable()\" placeholder=\"Filter Produktname...\"></td>",
	"<td>\n",
	"<select name=\"Arbeitsart\" id=\"filter2\" onchange=\"filterTable()\">\n",
	"<option value=\"\">Alle anzeigen</option>\n",
	"<option value=\"prA\">prA</option>\n",
	"<option value=\"iA\">iA</option>\n",
	"<option value=\"wA\">wA</option>\n",
	"</select>",
	"</td>\n",
	"<td>\n",
	"<select name=\"Technologie\" id=\"filter3\" onchange=\"filterTable()\">\n",
	"<option value=\"\">Alle anzeigen</option>\n",
	"<option value=\"Assistenzsystem\">Assistenzsystem</option>\n",
	"<option value=\"Dokumentation\">Dokumentation</option>\n",
	"<option value=\"Kommunikation\">Kommunikation</option>\n",
	"<option value=\"Robotik\">Robotik</option>\n",
	"<option value=\"Telecare\">Telecare</option>\n",
	"<option value=\"Plattform\">Plattform</option>\n",
	"</select>\n",
	"</td>\n",
	"<td><input type=\"text\" id=\"filter4\" onkeyup=\"filterTable()\" placeholder=\"Filter Kurzbeschreibung...\"></td>\n",
	rows
)

table=paste0("
<table id=\"products\" class=\"table\">
<thead>
  <tr>
    <th style=\"width:5%;color:white;\">Id</th>
    <th style=\"width:15%;color:white;\">Produktname</th>
    <th style=\"width:10%;color:white;\">Arbeitsart</th>	
    <th style=\"width:10%;color:white;\">Technologieart</th>
    <th style=\"width:60%;color:white;\">Kurzbeschreibung<br>(von Angebotswebsite)</th>
  </tr>
</thead>
<tbody>
",
paste0(rows,collapse=""),
"
</tbody>
</table> 
")

writeLines(table,paste0(Sys.Date(),"_updatedTable.html"))

table(feldA)
table(feldB)
sum(table(feldA))
