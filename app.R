library(twitteR)
library(ROAuth)
library(RCurl)

shinyApp(
  ui = fluidPage(
    fluidRow(
      column(4, textInput("searchkw", label = "search:", value = "#")),
      column(4, textInput("num", label = "number of tweets:", value = 10)),
      column(12, tableOutput('table'))
    )
  ),
  
  server = function(input, output) {
    
    # OAuth authentication
    consumer_key <- "keep your keys"
    consumer_secret <- "keep your keys"
    access_token <- "keep your keys"
    access_secret <- "keep your keys"
    options(httr_oauth_cache = TRUE) # enable using a local file to cache OAuth access credentials between R sessions
    setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
    
    # Issue search query to Twitter
    dataInput <- reactive({  
      tweets <- twListToDF(searchTwitter(input$searchkw, input$num , lang = "en" ))
                                         
      tweets$created <- as.character(tweets$created)
      tweets <- tweets
    })
    # Create a reactive table 
    output$table <- renderTable(
      dataInput()[, c("text", "screenName", "created")]
    )
  }
)