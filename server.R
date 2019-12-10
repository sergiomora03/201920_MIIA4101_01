#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$andes <- renderImage({
        filename <- normalizePath(file.path("./images/andes.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$downloadData <- downloadHandler(
        filename = "Presentación Análisis de movilidad.pdf",
        content = function(file) {
            file.copy("www/Presentacion_Analisis_de_movilidad.pdf", file)
        })
    
    output$downloadWrite <- downloadHandler(
        filename = "Informe_bici_uniandes.docx",
        content = function(file) {
            file.copy("www/Informe_bici_uniandes.docx", file)
        })
    
    output$downloadMap <- downloadHandler(
        filename = "Map_Movilidad.html",
        content = function(file) {
            file.copy("www/Map_Movilidad.html", file)
        })
    
    output$map1 <- renderLeaflet({
        localidad <- geojsonio::geojson_read("www/localidad-polygon.geojson", what = "sp")
        
        pal <- colorNumeric("viridis", NULL)
        
        leaflet(localidad) %>%
            addTiles() %>%
            addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                        fillColor = ~pal(log10(localidad$LocArea)),
                        label = ~paste0(LocNombre, ": ", formatC(localidad$LocArea, big.mark = ","))) %>%
            addLegend(pal = pal, values = ~log10(LocArea), opacity = 1.0,
                      labFormat = labelFormat(transform = function(x) round(10^x)))
    })
    
    
    output$map2 <- renderLeaflet({
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
    })
    
    
    output$map3 <- renderLeaflet({
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
    })
    
    
    output$map4 <- renderLeaflet({
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
            "<strong>%s</strong><br/>%s Medio </sup>",
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
    })
    
    
    output$pdf <- renderUI({
        
    })
    
    
    output$DecisionTree1 <- renderImage({
        filename <- normalizePath(file.path("./www/DecisionTree.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$geopandas1 <- renderImage({
        filename <- normalizePath(file.path("./www/geopandas1.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$geopandas2 <- renderImage({
        filename <- normalizePath(file.path("./www/geopandas2.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$geopandas3 <- renderImage({
        filename <- normalizePath(file.path("./www/geopandas3.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$geopandas4 <- renderImage({
        filename <- normalizePath(file.path("./www/geopandas4.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    output$data1 <- renderImage({
        filename <- normalizePath(file.path("./www/ranking medios de transporte predominantes.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$data2 <- renderImage({
        filename <- normalizePath(file.path("./www/Motivo de viaje por medio predominante.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$data3 <- renderImage({
        filename <- normalizePath(file.path("./www/Genero por medio predominante.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$data4 <- renderImage({
        filename <- normalizePath(file.path("./www/Edad por medio predominante.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    
    output$data5 <- renderImage({
        filename <- normalizePath(file.path("./www/distancia y sexo.png"))
        list(src = filename)
    }, deleteFile = FALSE)
    
    output$data6 <- renderImage({
        filename <- normalizePath(file.path("./www/correlation plot.png"))
        list(src = filename)
    }, deleteFile = FALSE)
})
