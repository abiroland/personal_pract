library(tidyverse)
library(rvest)

link <- "https://www.bbcgoodfood.com/recipes/collection/roast-chicken-recipes"

webpage <- read_html(link) |>
  html_nodes(".link.d-block") |>
  html_attr("href")


recipe_links <- tibble(new_links = webpage) |>
  unique() |>
  slice(1:24) |>
  mutate(
    comb_links = str_c("https://www.bbcgoodfood.com/", new_links)
  )


# function to extract recipe details
frames <- function(link){
  details <- vector("list", length(link))
  for (i in seq_along(link)) {
    details[[i]] <- read_html(link[[i]]) |>
      html_elements(css = ".post-header__servings .icon-with-text__children , 
                    .key-value-blocks__value , .body-copy-small:nth-child(1) time , 
                    .rating--inline .rating__count-text , .heading-1") |>
      html_text()
  }
  return(details)
}


# function to extract ingredients
ingredients <- function(link){
  details <- vector("list", length(link))
  for (i in seq_along(link)) {
    details[[i]] <- read_html(link[[i]]) |>
      html_elements(css = ".list-item--separator") |>
      html_text()
  }
  return(details)
}


# function to extract other items
df_madefrome <- tibble(items = frames(quick_healthy$comb_links)) |>
  unnest(cols = items) |>
  mutate(
    newcol = rep(c("recipe_name", "rating",
                      "prep", "servings", "total_kcal",
                      "fat", "saturates", "carbs",
                      "sugars", "fibre", "protein", "salt", "ingredients"), 
                 length.out = length(items))
  ) 


# make the data frames

# ingredients data frame
df_ingredients <- tibble(items = ingredients(quick_healthy$comb_links)) |>
  unnest(cols = items) |>
  reframe(
   ingred = paste(items, collapse = ", ")
 )

### last note: correct the ingredient data frame to collapse each ingred to a 
### single row

# items data frame
df_items <- df_madefrome |>
  pivot_wider(names_from = newcol, values_from = items,
              values_fn = list)|>
  unnest(cols = c(recipe_name:salt))




# Sunday lunch recipe
#roast chicken 

library(shiny)
library(shinycssloaders)
library(shinydashboard)
library(shinythemes)

ui <- fluidPage(
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
