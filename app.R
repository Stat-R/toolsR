do.call(require,c('shiny','leaflet','sp','rgdal','htmltools'),character.only )

source('C:/Users/A-Mudgal/Syncplicity Folders/Tools/TRZ/TRZ_functions.R')

ui = fluidPage(
ui <- bootstrapPage(
  h1('Shiny App 0.1'),
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("TRZ_map", width = "100%", height = "100%"),
    absolutePanel(top = 10, right = 10,
                  sliderInput("select_year", selected = 2010,
                              label = 'Select Year: ',choices = c(2010,2015))
    )
  )
  
  
)

server = function(input, output){
  output$some_text <- renderText({
    paste0('You selected this year # ',input$select_year)
  })
  spDF <- reactive(readOGR(dsn = 'ShapeFiles',layer = 'Old_New'))
  # shp_data <- readOGR(dsn = 'ShapeFiles',layer = 'Old_New') %>% spTransform(CRS('+init=epsg:4326'))  
  map_layer = 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
  
  output$shine_map <- renderLeaflet({
    shp_data <- spDF()
    
    #shp_data@data  = shp_data@data[shp_data$Pleca == input$select_year,]
    shp_data  = shp_data[shp_data$Pleca == input$select_year,]
    
    map_bounds <- shp_data@bbox %>% as.matrix()
    center_lon <- sum(map_bounds[1,])/2
    center_lat <- sum(map_bounds[2,])/2
    
    leaflet(data = shp_data)  %>% fitBounds(map_bounds[1,1], map_bounds[2,1], map_bounds[1,2], map_bounds[2,2]) %>%
      addTiles() %>% addTiles(urlTemplate =map_layer,options = providerTileOptions(opacity = 0.35)) %>%
      setView(lng = center_lon, lat = center_lat, zoom = 14) %>%
      addPolygons(data=shp_data,weight=4,color = col_vacant,opacity = .5,popup=
                    sprintf(gsub('\n','',"<b><font color ='red'>ID = %s</font><br>Pleca = %s</font><br>")
                            ,htmlEscape(shp_data$id),htmlEscape(shp_data$Pleca)))
  })
}
  shinyApp(ui = ui, server = server)