
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(leaflegend)
library(sf)
library(htmltools)

ATCs <- read.csv('ATCs in London.csv')

CPs <- read.csv('Minor CPs in London.csv')

ATCs_sf <- st_as_sf(ATCs, coords = c(x = "LONG", y = "LAT"), crs =  "WGS84")
CPs_sf <- st_as_sf(CPs, coords = c(x = "CP_Longitude", y = "CP_Latitude"), crs =  "WGS84")

ATCs_sf <- ATCs_sf %>% mutate(summary = paste0("<b>", "Site number = ", as.character(Site_Number),"</br> ", "RoadName = " , ROADNAME))

CPs_sf <- CPs_sf %>% mutate(summary = paste0("<b>", "CP number = ", as.character(CP),"</br> ", "RoadName = " , Road_Name))
                                                                
ATCs_B_roads <- ATCs_sf %>% filter(ROADCLASS == 'B')
ATCs_CU_roads <- ATCs_sf %>% filter(ROADCLASS == 'C' | ROADCLASS == 'U')
CPs_B_roads <- CPs_sf %>% filter(substring(Road_Number, 1, 1) == 'B')
CPs_CU_roads <- CPs_sf %>% filter(Road_Number == 'C' | Road_Number == 'U')

ATC_B_labels <- ATCs_B_roads$summary  %>% lapply(HTML)  
ATC_CU_labels <- ATCs_CU_roads$summary  %>% lapply(HTML)  
CP_B_labels <- ATCs_B_roads$summary  %>% lapply(HTML)  
CP_CU_labels <- ATCs_CU_roads$summary  %>% lapply(HTML)  

                                            


leaflet() %>% addProviderTiles(providers$OpenStreetMap) %>%   
  addCircles(data = ATCs_sf, 
             weight = 5, 
             opacity = 0.8,
             color = 'blue',
          #   color =  ~binpal(ATC_sites_shape$Strata),#"black",
             fillOpacity = 0.5,
           #  fillColor =~ binpal(ATC_sites_shape$Strata),# "blue",
             stroke = TRUE,
             radius = 50, 
            # label = ~labels_2,  
             #popup = ~labels_1, 
             group = "something",
             
             highlightOptions = highlightOptions(
               weight = 5,
               color = 'blue',
               opacity = 0.6, 
               fillOpacity = 0.8, 
               fillColor = "white")) %>% 
  
  addCircles(data = CPs_sf, 
             weight = 5, 
             opacity = 0.8,
             color = 'red',
             #   color =  ~binpal(ATC_sites_shape$Strata),#"black",
             fillOpacity = 0.5,
             #  fillColor =~ binpal(ATC_sites_shape$Strata),# "blue",
             stroke = TRUE,
             radius = 50, 
             # label = ~labels_2,  
             #popup = ~labels_1, 
             group = "something",
             
             highlightOptions = highlightOptions(
               weight = 5,
               color = 'red',
               opacity = 0.6, 
               fillOpacity = 0.8, 
               fillColor = "white"))





%>% 
  
  addSearchFeatures(targetGroups = "something",
                    options = 
                      searchFeaturesOptions(
                        zoom = 12, 
                        openPopup = TRUE, 
                        firstTipSubmit = TRUE,
                        autoCollapse = TRUE, 
                        hideMarkerOnCollapse = TRUE, 
                        position =  "topright"
                      ))