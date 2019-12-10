#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# dashboardPage(skin = "yellow")


library(shinydashboard)
library(shinyWidgets)
library(leaflet)

dashboardPage(
    skin = "yellow",
    dashboardHeader(title = "Dashboard"),
    dashboardSidebar(
        sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                          label = "Search..."),
        sidebarMenu(
            menuItem("Analytics", tabName = "Analytics", icon = icon("chart-bar")),
            menuItem("Template", tabName = "pdf", icon = icon("chalkboard")),
            menuItem("Notebook", tabName = "Notebook", icon = icon("book")),
            menuItem("Descriptive", tabName = "Descriptive", icon = icon("chart-line"),
                     menuSubItem("Descriptive Geopandas", tabName = "Descriptive_geop", icon = icon("globe-americas")),
                     menuSubItem("Descriptive Data", tabName = "Descriptive_data", icon = icon("chart-line"))
                     ),
            menuItem("Georeferenciación", tabName = "Georef", icon = icon("globe-americas"),
                     menuSubItem("Prueba", tabName = "map_1"), 
                     menuSubItem("Choropleths", tabName = "map_2"),
                     menuSubItem("mapa preliminar", tabName = "map_3"),
                     menuSubItem("mapa origen viajes", tabName = "map_4")
                     ),
            menuItem("Decision Tree", tabName = "DesicionTree", icon = icon("sitemap")),
            menuItem("Code", tabName = "Code", icon = icon("terminal"), badgeLabel = "new", badgeColor = "green")
        ),
        hr(),
        HTML("&nbsp"),
        HTML("&nbsp"),
        downloadButton("downloadData", "Download presentation"),
        br(),
        br(),
        HTML("&nbsp"),
        HTML("&nbsp"),
        HTML("&nbsp"),
        HTML("&nbsp"),
        downloadButton("downloadWrite", "Download writing"),
        br(),
        br(),
        HTML("&nbsp"),
        HTML("&nbsp"),
        HTML("&nbsp"),
        HTML("&nbsp"),
        HTML("&nbsp"),
        downloadButton("downloadMap", "Download Map")
    ),
    dashboardBody(
        tags$head(tags$link(rel = "shortcut icon", href = "https://www.uniandes.edu.co/sites/default/files/favicon.ico")),
        tabItems(
            tabItem(tabName = "Analytics",
                    fluidRow(
                        box(
                            width = 6,
                            imageOutput("andes"),
                            h2("Maestría en Inteligencia Analítica para la Toma de Decisiones")
                        ),
                        box(title = h1("Herramientas Computacionales para el Análisis de Datos"),
                            br(),
                            h3("Profesor: Camilo Gómez"),
                            "Fecha: 11-12-19",
                            br(),
                            br(),
                            h2("Integrantes:"),
                            br(),
                            h4("Carolina Padilla Hernández - 201111402"),
                            h4("Sergio A. Mora Pardo - 201920547"),
                            h4("Diego López Veásquez - 201924226"),
                            h4("Fabián Cholo Acevedo - 201523509"),
                            h4("Jairo Alberto Pedraza - 201924260")
                        )
                    ),
                    fluidRow(
                        box(
                            title = "Pregunta de Negocio",
                            solidHeader = T,
                            width = 12,
                            status = "warning",
                            collapsible = T,
                            collapsed = T,
                            h2("¿Qué lugar ocupa la bicicleta como medio de transporte en Bogotá y cúales son las carácteristicas que incrementan su uso?")
                            )
                    ),
                    
                    fluidRow(
                        box(
                            title = "Objetivos de Investigación",
                            solidHeader = T,
                            width = 12,
                            status = "warning",
                            collapsible = T,
                            collapsed = T,
                            h3("1. Describir los medios de transporte predominantes y las características de la población usuaria."),
                            h3("2. Identificar la distribución del uso de la bicicleta en la ciudad de Bogotá."),
                            h3("3. Establecer las características que incrementan el uso de la bicicleta en Bogotá.")
                        ),
                        
                    fluidRow(
                        box(
                            title = "Nivel Enuesta-Grupo",
                            solidHeader = F,
                            width = 4,
                            #status = "warning",
                            collapsible = T,
                            collapsed = T,
                            background = "green",
                            h3("- Barrio"),
                            h3("- Tipo de Vivienda"),
                            h3("- Estrato Socioeconómico"),
                            h3("- No. Personas")
                        ),
                        box(
                            title = "Nivel Personas",
                            solidHeader = F,
                            width = 4,
                            #status = "warning",
                            collapsible = T,
                            collapsed = T,
                            background = "light-blue",
                            h3("- Sexo"),
                            h3("- Edad"),
                            h3("- Nivel Educativo"),
                            h3("- Act. Principal"),
                            h3("- Act. Económica"),
                            h3("- Uso de Bicicleta"),
                            h3("- Motivos de Uso de la Bicleta")
                        ),
                        box(
                            title = "Nivel Viajes",
                            solidHeader = F,
                            width = 4,
                            #status = "warning",
                            collapsible = T,
                            collapsed = T,
                            background = "maroon",
                            h3("- Motivo de Viaje"),
                            h3("- Medio de Transporte Predominante"),
                            h3("- Lugar de Origen"),
                            h3("- Lugar de Destino"),
                            h3("- Duración del viaje"),
                            h3("- Hora del viaje")
                        )
                    )
                )
            ),
            tabItem("Notebook", 
                    tags$iframe(style = "height:600px; width:100%; scrolling=yes",
                                src = "Entrega_II Herramientas Computacionales.html")
                    ),
            tabItem("Descriptive_data",
                    fluidRow(
                        box(title = h2("Ranking medios de transporte predominantes"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data1")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Motivo de viaje por medio predominante"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data2")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Genero por medio predominante"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data3")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Edad por medio predominante"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data4")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Edad por medio predominante"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data5")
                        )
                    ),
                    fluidRow(
                        box(title = h2("correlation plot"),
                            solidHeader = T,
                            width = 12,
                            height = "1000px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("data6")
                        )
                    )
                ),
            tabItem("Descriptive_geop",
                    fluidRow(
                        box(title = h2("Mapa de densidad de viajes por Localidad"),
                            solidHeader = T,
                            width = 9,
                            height = "700px",
                            status = "warning",
                            collapsible = F,
                            collapsed = T,
                            imageOutput("geopandas1")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Mapa de medio de transporte por localidad"),
                            solidHeader = T,
                            width = 11,
                            height = "600px",
                            status = "warning",
                            #collapsible = T,
                            #collapsed = T,
                            imageOutput("geopandas2")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Mapa de motivo de viaje predominate por Localidad"),
                            solidHeader = T,
                            width = 11,
                            height = "600px",
                            status = "warning",
                            #collapsible = T,
                            #collapsed = T,
                            imageOutput("geopandas3")
                        )
                    ),
                    fluidRow(
                        box(title = h2("Mapa de genero por Localidad"),
                            solidHeader = T,
                            width = 11,
                            height = "800px",
                            status = "warning",
                            #collapsible = T,
                            #collapsed = T,
                            imageOutput("geopandas4")
                        )
                    )
                ),
            tabItem("pdf",
                    tags$iframe(style = "height:600px; width:100%; scrolling=yes", 
                                src = "Presentacion_Analisis_de_movilidad.pdf")
                    ),
            tabItem(tabName = "map_1",
                    leafletOutput("map1")
                    #h2("Datos Georeferenciados"),
                    #fluidRow(
                    #    box(
                    #        title = "Tester leaflet",
                    #        solidHeader = T,
                    #        width = 12,
                    #        status = "warning",
                    #        collapsible = T,
                    #        
                    #    )
                    #)
                ),
            tabItem(tabName = "map_2",
                    leafletOutput("map2")),
            tabItem(tabName = "map_3",
                    leafletOutput("map3")),
            tabItem(tabName = "map_4",
                    leafletOutput("map4")),
            tabItem(tabName = "DesicionTree",
                    box(title = h2("Arbol de Decisión"),
                        solidHeader = T,
                        width = 18,
                        status = "warning",
                        imageOutput("DecisionTree1")
                    )
                ),
            tabItem(tabName = "Code",
                    h2("Code here!")
                    )
        )
    )
)