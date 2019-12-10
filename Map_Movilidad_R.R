
# Ejemplo marcador
library(leaflet)

#prueba -----------------------------------------------------------------------
#Cargue de la capa
localidad <- geojsonio::geojson_read("www/localidad.geojson", what = "sp")

pal <- colorNumeric("viridis", NULL)

leaflet(localidad) %>%
  addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
              fillColor = ~pal(log10(localidad$LocArea)),
              label = ~paste0(LocNombre, ": ", formatC(localidad$LocArea, big.mark = ","))) %>%
  addLegend(pal = pal, values = ~log10(LocArea), opacity = 1.0,
            labFormat = labelFormat(transform = function(x) round(10^x)))



#Choropleths -----------------------------------------------------------------------
localidad <- geojsonio::geojson_read("www/localidad-polygon.geojson", what = "sp")

localidad$pv_mujer


m <- leaflet(localidad) %>%
  setView(-74.075979, 4.598383,zoom = 9) %>%
  addProviderTiles("MapBox", options = providerTileOptions(
    id = "mapbox.light",
    accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN')))

#Adding some color
bins <- c(0,10,20,30,40,50,60,70,80,90,Inf)
pal <- colorBin("YlOrRd", domain = localidad$pv_mujer, bins = bins)

#Adding interaction
m %>% addPolygons(
  fillColor = ~pal(pv_mujer),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE))



#mapa preliminar -----------------------------------------------------------------------
localidad <- geojsonio::geojson_read("www/localidad-polygon.geojson", what = "sp")

m <- leaflet(localidad) %>%
  setView(-74.075979, 4.598383,zoom = 9) %>%
  addProviderTiles(providers$CartoDB.Positron)

#Adding some color
bins <- c(0,10,20,30,40,50,60,70,80,90,Inf)
pal <- colorBin("YlOrRd", domain = localidad$pv_mujer, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g LEYENDA </sup>",
  localidad$LocNombre, localidad$pv_mujer
) %>% lapply(htmltools::HTML)

m <- m %>% addPolygons(
  fillColor = ~pal(pv_mujer),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto"))

m %>% addLegend(pal = pal, values = ~pv_mujer, opacity = 0.6, title = NULL,
                position = "bottomright")









#mapa origen viajes -----------------------------------------------------------------------

localidad <- geojsonio::geojson_read("www/localidad-polygon.geojson", what = "sp")

localidad$pv_origen
quantile(localidad$pv_origen)

m <- leaflet(localidad) %>%
  setView(-74.075979, 4.598383,zoom = 9) %>%
  addProviderTiles(providers$CartoDB.Positron)

#Adding some color
bins <- c(0, 2, 4, 5, 7, 9,Inf)
pal <- colorBin("YlOrRd", domain = localidad$pv_origen, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g Medio </sup>",
  localidad$LocNombre, localidad$MEDIO_1
) %>% lapply(htmltools::HTML)

m <- m %>% addPolygons(
  fillColor = ~pal(localidad$pv_origen),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto"))

m %>% addLegend(pal = pal, values = ~pv_origen, opacity = 0.6, title = NULL,
                position = "bottomright")








