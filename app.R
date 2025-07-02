library(shiny)
library(shinydashboard)
library(shinyjs)
library(V8)

ui <- dashboardPage(
  title = "Visible Vowels",

  dashboardHeader
  (
    title = a(href   = 'https://www.fryske-akademy.nl/en/',
                        img(src   = 'FA1.png', 
                            title = "Fryske Akademy", 
                            width = "180px",
                            style = "margin-left: -6px; padding-top: 0px; padding-bottom: 10px;"
                        ), 
              target = "_blank"
            )
  ),

  dashboardSidebar
  (
    p(class = "visvow", "Visible Vowels"),
   
    sidebarMenu
    (
      id = "tabs",

      menuItem("Introduction" , tabName = "introduction" , icon = shiny::icon("thumbs-up" )),
      menuItem("Data set"     , tabName = "dataset"      , icon = shiny::icon("user"        )),
      menuItem("Data format"  , tabName = "dataformat"   , icon = shiny::icon("file"        )),
      menuItem("Contours"     , tabName = "contours"     , icon = shiny::icon("line-chart"  )),
      menuItem("Formants"     , tabName = "formants"     , icon = shiny::icon("desktop"     )),
      menuItem("Dynamics"     , tabName = "dynamics"     , icon = shiny::icon("area-chart"  )),
      menuItem("Duration"     , tabName = "duration"     , icon = shiny::icon("bar-chart"   )),
      menuItem("Explore"      , tabName = "explore"      , icon = shiny::icon("gear"        )),
      menuItem("Evaluate"     , tabName = "evaluate"     , icon = shiny::icon("lightbulb"))
    )
  ),

  dashboardBody
  (
       useShinyjs(),
    extendShinyjs(script = "extend.js", functions = c("scrolltop")),
    
    tags$head
    (
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
      tags$link(rel = "icon", href = "FA2.png")
    ),

    tabItems
    (
      tabItem(tabName = "introduction" , uiOutput ("introduction" )),
      tabItem(tabName = "dataset"      , uiOutput ("dataset"      )),
      tabItem(tabName = "dataformat"   , uiOutput ("dataformat"   )),
      tabItem(tabName = "contours"     , uiOutput ("contours"     )),
      tabItem(tabName = "formants"     , uiOutput ("formants"     )),
      tabItem(tabName = "dynamics"     , uiOutput ("dynamics"     )),
      tabItem(tabName = "duration"     , uiOutput ("duration"     )),
      tabItem(tabName = "explore"      , uiOutput ("explore"      )),
      tabItem(tabName = "evaluate"     , uiOutput ("evaluate"     ))
    )
  )
)

server <- function(input, output, session)
{
  observeEvent(input$tabs,
  {
    js$scrolltop()
  })
  
  observeEvent(input$tabs,
  {
    if (getUrlHash() == paste0("#", input$tabs)) return()
    updateQueryString(paste0("#", input$tabs), mode = "push")
  })

  observeEvent(getUrlHash(),
  {
    Hash <- getUrlHash()
    if (Hash == paste0("#", input$tabs)) return()
    Hash <- gsub("#", "", Hash)
    updateTabsetPanel(session, "tabs", selected=Hash)
  })

  observeEvent(input$next1,
    updateTabItems(session, "tabs", switch(input$tabs, "introduction"  = "dataset"      , "dataset"       = "introduction" ))
  )

  observeEvent(input$previous2,
    updateTabItems(session, "tabs", switch(input$tabs, "introduction"  = "dataset"      , "dataset"       = "introduction" ))
  )

  observeEvent(input$next2,
    updateTabItems(session, "tabs", switch(input$tabs, "dataset"       = "dataformat"   , "dataformat"    = "dataset"      ))
  )
  
  observeEvent(input$previous3,
    updateTabItems(session, "tabs", switch(input$tabs, "dataset"       = "dataformat"   , "dataformat"    = "dataset"      ))
  )

  observeEvent(input$next3,
    updateTabItems(session, "tabs", switch(input$tabs, "dataformat"    = "contours"     , "contours"      = "dataformat"   ))
  )
  
  observeEvent(input$previous4,
    updateTabItems(session, "tabs", switch(input$tabs, "dataformat"    = "contours"     , "contours"      = "dataformat"   ))
  )

  observeEvent(input$next4,
    updateTabItems(session, "tabs", switch(input$tabs, "contours"      = "formants"     , "formants"      = "contours"     ))
  )

  observeEvent(input$previous5,
    updateTabItems(session, "tabs", switch(input$tabs, "contours"      = "formants"     , "formants"      = "contours"     ))
  )

  observeEvent(input$next5,
    updateTabItems(session, "tabs", switch(input$tabs, "formants"      = "dynamics"     , "dynamics"      = "formants"     ))
  )

  observeEvent(input$previous6,
    updateTabItems(session, "tabs", switch(input$tabs, "formants"      = "dynamics"     , "dynamics"      = "formants"     ))
  )

  observeEvent(input$next6,
    updateTabItems(session, "tabs", switch(input$tabs, "dynamics"      = "duration"     , "duration"      = "dynamics"     ))
  )
  
  observeEvent(input$previous7,
    updateTabItems(session, "tabs", switch(input$tabs, "dynamics"      = "duration"     , "duration"      = "dynamics"     ))
  )

  observeEvent(input$next7,
    updateTabItems(session, "tabs", switch(input$tabs, "duration"      = "explore"      , "explore"       = "duration"     ))
  )

  observeEvent(input$previous8,
    updateTabItems(session, "tabs", switch(input$tabs, "duration"      = "explore"      , "explore"       = "duration"     ))
  )
   
  observeEvent(input$next8,
    updateTabItems(session, "tabs", switch(input$tabs, "explore"       = "evaluate"     , "evaluate"      = "explore"      ))
  )
  
  observeEvent(input$previous9,
    updateTabItems(session, "tabs", switch(input$tabs, "explore"       = "evaluate"     , "evaluate"      = "explore"      ))
  )

  output$introduction <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Introduction"),

      p("Visible Vowels is a web app that makes it very easy to analyze and visualize acoustic vowel measurements such as f0, formants and duration. The app is a useful instrument for research in phonetics, sociolinguistics, dialectology, forensic linguistics, and speech-language pathology."),

      h2("Features:"),
      
      tags$ul(
        tags$li("Combines user friendliness with maximum flexibility and functionality."),
        tags$li("Is web-based."),
        tags$li("Uses a live view: each time something is changed in the settings, the plot shown in the viewer is immediately adjusted accordingly."),
        tags$li("Visualization of contours of f0 or formants, of vowels either in two- or three-dimensional space, of vowel dynamics, of vowel duration and of the relationships between speakers."),
        tags$li("Implemented in R using the ", span(class="mono", "shiny"), " package."),
        tags$li("Available online at ", a("visiblevowels.org", onclick="window.open('https://www.visiblevowels.org/', '_blank'); return false;", target = "_blank", style='cursor:pointer; text-decoration: none; outline: none;', class="mono"), " and as R package ", span(class="mono", "visvow"), " in the CRAN repository.")
      ),

      h2("Let's go!"),
      
      p("This tutorial guides you through Visible Vowels and offers detailed examples demonstrating many of its capabilities. Click the Next button to get started."),
      
      br(),
      
      splitLayout
      (
        align = "center", cellWidths = "110px",
        actionButton("next1"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$dataset <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1(style='color: #c09853; font-weight: bold;', "Data set"),

      p("The data we use in this tutorial is a data set that was compiled by Van
         der Harst (2011). He measured f0, formants and vowel duration of the 15
         full vowels of Dutch on the basis of word list data, i.e. monosyllabic
         words, before coda [s] and [t]. The speakers are 160 teachers of Dutch
         at high schools and were recorded in 1999/2000. They were selected
         according to dialectological and socio-geographic criteria via schools
         in medium-sized cities. The data set is stratified by community (The
         Netherlands and Flanders), region (four regions in each community), sex
         (male, female) and age (old, young)."),
      
      p("The map below shows the Dutch language area and the towns in which the
         teachers worked at the time of the interview. Towns represented by a
         dot of the same color belong to the same region."),
         
      img(src = 'map.png', class = "center"),
        
      br(),
      
      p("Van der Harst (2011) writes that the teachers 'had to meet the
         following requirements: 1. At the time of the interview, they had to
         live in one of the selected towns, or in a village near that town in
         the same dialect region. 2. They had to have lived in the region for at
         least eight years prior to their 18th birthday. 3. They had to be born
         in the region or to have moved there before their eighth birthday.'"),
   
      p("The teachers were divided into two age groups. The speakers in the
         youngest group were between 22 and 40 years old at the time of the
         interview and speakers in the oldest group were between 45 and 60 years
         old. As for the factor gender, the biological sex distinction was used.
         Each of the eight regions was represented by 20 speakers: five young
         men, five older men, five young women, and five older women."),
      
      p("For more details see: ",
         a(href = 'https://www.lotpublications.nl/Documents/273_fulltext.pdf',
         span("Van der Harst, S. (2011).", span(style="font-style: italic", "The
         Vowel Space Paradox: a Sociophonetic Study on Dutch."), "Ph.D. thesis
         Radboud University of Nijmegen. Utrecht: LOT."), target = "_blank")),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Download the
         data set", a("here", href = "Van der Harst 2011.xlsx", target =
         "_blank"), "and save it at a location on your hard disk where you can
         easily find it."),

      br(),
      
      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous2", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next2"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$dataformat <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Data format"),
              
      p("The input file to be loaded in Visible Vowels should be a spreadsheet
         that is created in Excel or LibreOffice. It should be saved as an Excel
         2007/2010/2013 XML file, i.e. with extension '.xlsx'. An example is
         schematically shown here:"),

      div(img(src = 'format.png', style='display: block; margin-left: auto; margin-right: auto; height: 300px;'), style='overflow-x:auto;'),
      
      br(),
      
      tags$div(tags$ul(
        tags$li(tags$span(HTML("<span style='color:blue'>speaker</span><span style='color:#4d88ff'> (purple column)</span>"),p("The first column should contain the speaker labels. Choose 'speaker' as column name. In our example there are three speakers labeled as 'A', 'B' and 'C'. This column is obligatory."))),
        tags$li(tags$span(HTML("<span style='color:blue'>vowel</span><span style='color:#4d88ff'> (yellow column)</span>"),p("A column that contains the vowel labels should follow. For this column choose 'vowel' as column name. In our example each of the speakers pronounced four different vowels: i\u02D0, \u025B, a\u02D0 and \u0254. Although in this table each vowel occurs just one time per speaker, multiple pronunciations are possible. In case you want to use IPA characters (as in the example), enter them as Unicode characters. In order to find Unicode IPA characters, use the online ", a(href = 'http://westonruter.github.io/ipa-chart/keyboard/', span("IPA Chart Keyboard"), target = "_blank"), " of Weston Ruter. This column is obligatory."))),
        tags$li(tags$span(HTML("<span style='color:blue'>categorical variables</span><span style='color:#4d88ff'> (white columns)</span>"),p("An arbitrary number of columns representing categorical variables such as location, language, gender, age group, etc. may follow, but is not obligatory. See to it that each categorical variable has an unique set of different values. Prevent the use of numbers, rather use meaningful codes. For example, rather then using codes '1' and '2' for a variable 'age group' use 'old' and 'young' or 'o' and 'y'."))),
        tags$li(tags$span(HTML("<span style='color:blue'>duration</span><span style='color:#4d88ff'> (green column)</span>"),p("A column which contains the durations of the vowels should follow, with 'duration' as column name. The measurements may be either in seconds or milliseconds. This column is obligatory, but may be empty."))),
        tags$li(tags$span(HTML("<span style='color:blue'>spectral variabels</span><span style='color:#4d88ff'> (blue columns)</span>"),p("Finally, a set of five columns should follow: 'time', f0', 'F1', 'F2' and 'F3'. The variable 'time' gives the time point within the vowel interval in seconds or milliseconds, i.e. it is assumed that the vowel interval starts at 0 (milli)seconds. The f0, F1, F2 and F3 should be measured at the time given in the column 'time'. The program assumes that they are measured in Hertz and not normalized. The set of five columns may be repeated as ",em("many times"), " as the user wishes, but should occur at least one time. For each repetition the same column names may be used. In the example table f0, F1, F2 and F3 are given for two different time points, hence the set of five columns comprising 'time', 'f0', 'F1', 'F2' and 'F3' occurs twice. A set should always include all five columns, but the columns 'time', 'f0' and 'F3' may be empty.")))
      )),
      
      h2("Load the data set"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "In the previous
         session we downloaded the data set of Van der Harst (2011). It was
         saved as 'Van der Harst 2011.xlsx'. Now open ", 
         
        a("Visible Vowels", 
           href   = "https://www.visiblevowels.org/", 
           target = "_blank"
        ),
        
        "and go to the tab 'Load file' (if that tab is not the currently
         selected tab). Then you will see the following:"),
      
      br(),
      
      img(src = 'Load file.png', class = "center"),

      br(),
      
      p("Click on 'browse' and find 'Van der Harst 2011.xlsx' where you
         previously saved it. Open the file. The table will be shown."),
         
      p(span(shiny::icon("question-circle"), class='Icon'), "Take some time to
         look at the table. Does it comply with the formatting guidelines? How
         many categorical variables does this data set have? How many time
         points are there?"),
      
      br(),
      
      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous3", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next3"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$contours <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Contours"),

      p("In this session we will focus on visualizing and comparing f0 contours,
         but visualization of formant contours (F1, F2, F3) is possible as
         well."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
         'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
         you previously saved it. Open the file. The table will be shown. Then
         choose 'Contours' in the top navigation bar."),

      h2("f0 contours across regions"),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "In this section
         we will compare f0 contours across regions and vowels."),

      tags$ul(
        tags$li(HTML("Enter a <b>plot title</b>: 'f0 contours across vowels and
                      regions'.")),
        tags$li(HTML("Select a <b>scale</b>. A common psycho-acoustic pitch
                      scale for f0 measures is the semitone scale. So choose
                      'ST'.")),
        tags$li(HTML("When choosing the semitone scale, an input field pops up
                      that enables you to choose a <b>reference frequency</b>.
                      Just keep the default value of 50 which centers the
                      semitone scale at 50 Hz = 0 semitones.")),
        tags$li(HTML("Choose the 95% <b>confidence interval</b> that uses the
                      standard error (SE).")),
        tags$li(HTML("Underneath <b>variable</b> select 'f0', and underneath
                      <b>Select points</b> select all points except for the
                      first and the last point. I.e. choose the 25%, 38%, 50%,
                      62% and 75% point in the vowel interval.")),
        tags$li(HTML("As <b>color variable</b> select 'vowel' and below
                      <b>Select colors</b> choose 'a'.")),
        tags$li(HTML("As <b>panel variable</b> choose 'region', and select all
                      regions below <b>Select panels</b>.")),
        tags$li(HTML("In order to make the contours more looking like real
                      contours, uncheck 'points' below <b>Options</b>, and check
                      smooth. Checking the latter option causes the contours to
                      be smoothed by a spline interpolation."))
      ),
        
      p("You may have noticed that when following the instructions and/or
         changing the settings, the results are immediately changed accordingly.
         The final result should look like this:"),

      div(img(src = 'contours1.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), "Which regions have
         a strongly rising contour? Which have a more flat contour?"),
      
      h2("f0 contours across regions and vowels"),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Now let's
         compare vowel [a] with vowel [ɑ] for only the male speakers."),

      tags$ul(
        tags$li(HTML("Choose 0% as <b>size of confidence intervals</b>.")),
        tags$li(HTML("In the <b>Color variable</b> menu scroll a bit down until
                      the variable 'sex' becomes visible. Then click on this
                      variable while holding the Ctrl key (when using an Apple
                      computer the command key). ")),
        tags$li(HTML("Under <b>Select colors</b> click on 'a', then hold the
                      Ctrl key (or command key) and click on 'ɑ'."))
      ),

      p("You will obtain the following result:"),

      div(img(src = 'contours2.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),

      p(span(shiny::icon("question-circle"), class='Icon'), "Describe the way
         vowels [a] and [ɑ] differ across the regions. For which region do you
         find the most striking difference?"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Let's save the
         results that we obtained. First we will save the part of the data that
         was used for creating the graph. Below the graph you find a button
         'Table'. Left of this button you can choose the format in which the
         table should be saved. There are two formats: txt and xlsx. When
         choosing txt, the table will be saved as a tab-delimited file. When
         choosing xlsx, the table will be saved in Excel format. Both a txt file
         and a xlsx file can be read by Microsoft Excel or LibreOffice Calc."),
      
      p("Let's choose xlsx and click on the 'Table' button in order to save the
         table. The file is named 'contoursTable.xlsx'. Once you have saved the
         file, open the file in Excel or Calc."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Next we will 
         download the graph. Below the graph and completely to the right you
         find a button 'Graph'. On the left of this you find four buttons:"),
            
      tags$ul(
        tags$li(HTML("With the leftmost button you can enlarge or reduce the
                      lines, dots and letters globally. Options are: 'large',
                     'medium' and 'small'. Default is 'medium'. Select 
                     'large'.")),
        tags$li(HTML("With the next button you can choose a font. Experiment
                      with them. In case you would like to include the graph
                      in a paper, choose the font that most closely resembles
                      the font used in the paper.")),
        tags$li(HTML("With the third button the font size can be set. Default 
                      is 22. Choose the font size so that the axis tick mark
                      labels do not overlap each other.")),
        tags$li(HTML("With the button immediately to the left of the 'Graph'
                      button you can choose from five file formats. Keep the
                      default 'PNG'."))
      ),
      
      p("Click on the 'Graph' button in order to download the graph to your hard
         disk. Generating the file takes some time, so just wait. The file will
         be saved as 'contoursPlot.PNG'. Always view the file that you saved,
         since it may slightly differ from the graph shown in Visible Vowels
         itself."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Suggestions for
         further experimenting:"),
      
      tags$ul(
        tags$li(HTML("Add some more vowels under 'Select colors'.")),
        tags$li(HTML("Select only vowel [a], and visualize the differences
                      between old and young for a few regions")),
        tags$li(HTML("Experiment with F1, F2 and F3."))
      ),
      
      br(),
      
      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous4", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next4"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$formants <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Formants"),

      p("The tab 'Formants' is designed for displaying the first three formants
         - F1, F2, F3 - by means of two- or three-dimensional formant plots.
         We get to know the possibilities of this tab on the basis of seven
         examples."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
        'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
        you previously saved it. Open the file. The table will be shown. Then
        choose 'Formants' in the top navigation bar."),
      
      h2("The spread of the corner vowels"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("We study
         the spread of the corner vowels [i], [u] and [a] for four regions. Do
         the following:")),
      
      tags$ul(
        tags$li(HTML("As plot title enter: 'Spread of corner vowels'.")),
        tags$li(HTML("At <b>Time points to be shown</b> retain 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'vowel', and at <b>Select
                      colors</b> select 'i', 'u' and 'a'.")),
        tags$li(HTML("At <b>Panel variable</b> select 'region', and at <b>Select
                      panels</b> select 'NL-Middle', 'NL-North', 'NL-Randstad'
                      and 'NL-South'. First select 'NL-Middle' and hold down the
                      left mouse button, then drag the mouse over the other
                      three regions.")),
        tags$li(HTML("Check 'cent.'")),
        tags$li(HTML("At <b>Confidence level</b> retain 95%. ")),
      ),
      
      br(),
      div(img(src = 'formant1.png', style='display: block; margin-left: auto; margin-right: auto; height: 500px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Which
         vowel has the largest F1 spread? Which vowel has the largest F2 
         spread? Which vowel has the smallest spread in both dimensions? Can
         you explain these results?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Play around
         with (combinations of) the options 'labels', 'cent.', 'hull', 'spokes'
         and 'ellipse'. When 'ellipse' is checked, experiment with different
         percentages of the confidence level.")),
      
      h2("Visualizing sound change"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("We
         visualize the change of [a] and [ɑ]. Do the following:")),
      
      tags$ul(
        tags$li(HTML("Enter as plot title: 'Change of [a] and [ɑ]'")),
        tags$li(HTML("At <b>Time points to be shown</b> retain 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'vowel', and at <b>Select
                      colors</b> select 'a' and 'ɑ'.")),
        tags$li(HTML("At <b>Shape variable</b> select 'sex' and 'age'. First,
                      click on 'sex', then Ctrl+click (on an Apple computer
                      command+click) on 'age'.")),
        tags$li(HTML("At <b>Select shapes</b> select 'female old' and 'female
                      young'.")),
        tags$li(HTML("At <b>Panel variable</b> select 'region', and at <b>Select
                      panels</b> select all regions.")),
        tags$li(HTML("Check 'average'.")),
        tags$li(HTML("At the left of the graph check 'min/max'; at <b>min. x</b>
                      enter '100', and at <b>max. x</b>  enter '1800'.")),
        tags$li(HTML("Underneath the graph change the font size from 22 to
                      15.")),
      ),

      p("The result should look like this:"),
      
      div(img(src = 'formant4.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 450px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Compare the
         vowels pronounced by the younger female speakers with those pronounced
         by the older female speakers. In which areas are the vowels raised? In
         which areas are they lowered? In which areas has the difference between
         [a] and [ɑ] become smaller?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Instead
         of comparing older and younger female speakers compare older and younger
         male speakers.")),

      h2("Scaling and normalization"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Let's compare
         the vowels of younger female speakers with the vowels of older female
         speaker in 'NL-north':"),
      
      tags$ul(
        tags$li(HTML("Enter as plot title: 'vowel change NL-north'")),
        tags$li(HTML("At <b>Time points to be shown</b> select 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'vowel'.")),
        tags$li(HTML("At <b>Select colors</b> select all vowels.")),
        tags$li(HTML("At <b>Shape variable</b> select 'sex' and 'age'. First,
                      click on 'sex', then Ctrl+click (on an Apple computer
                      command+click) on 'age'.")),
        tags$li(HTML("At <b>Select shapes</b> select 'female old' and 'female
                      young'.")),
        tags$li(HTML("At <b>Panel variable</b> select 'region', at <b>Select
                      panels</b> select 'NL-North'.")),
        tags$li(HTML("Check 'labels'.")),
        tags$li(HTML("Check 'average'.")),
      ),
      
      p("The result should look like this:"),
      
      div(img(src = 'formant5.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),
      
      br("Wow! The whole vowel system has shifted in the F1 dimension. The
          younger female speakers pronounced almost all vowels with a lower
          F1 than the older female speakers. Really? No! Let's scale and
          normalize the formant frequencies. As conversion scale we use
          'ERB: Greenwood (1961)' ('ERB I in the evaluate tab') and as
          normalization method we use 'Lobanov (1971)'."),
      
      br("Why ERB I with Lobanov? Using our data set we found in the
          evaluate tab that this combination was one of the best according
          to all five evaluation methods."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Choose
          'ERB: Greenwood (1961)' at <b>Scale</b> and 'Lobanov (1971)' at
          <b>Normalization</b>.")),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("What are your
          findings now?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("The vowel
          differences between older and younger female speakers can also be
          visualized as follows:")),
      
      div(img(src = 'formant6.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),
      
      p("Try to figure out how to create this graph yourself."),

      h2("Visualizing diphthongization"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("In this 
         section we visualize the diphthongization of the long vowels [eː],
         [øː] and [oː] in Flemish and Netherlandic Dutch. Their formant
         trajectories are obtained by the following steps:")),
      
      tags$ul(
        tags$li(HTML("Enter as <b>plot title</b>: 'Diphthongization of [e], [ø]
                      and [o]'")),
        tags$li(HTML("At <b>Time points to be shown</b> select 25%, 38%, 50%,
                      62%, 75%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'vowel', and at <b>Select
                      colors</b> select 'e', 'ø' and 'o'.")),
        tags$li(HTML("At <b>Panel variable</b> select 'region', and at <b>Select
                      panels</b> select 'NL-Randstad' and 'FL-Brabant'")),
        tags$li(HTML("Check 'smooth trajectories'.")),
        tags$li(HTML("Check 'average'.")),
        tags$li(HTML("At the left of the graph uncheck 'min/max'.")),
        tags$li(HTML("Underneath the graph set the font size to 22.")),
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Compare the
         two regions. What do you notice?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Also visualize
         the diphthongation of [i], [y] and [u], and the diphthongization of [a]
         and [ɑ] in a similar way."),
      
      h2("Visualizing vowel space overlap"),
      
      p("In the evaluate tab we find two evaluation methods that have been
         proposed by Fabricius et al. (2009), one of which we refer to as
         'improve vowel space overlap'. This method measures the area of the
         intersection of the speaker's vowel spaces and divides this by the area
         of the union of the speaker's vowel spaces. Higher outcomes indicate
         more overlap. According to this evaluation method the best score is 
         obtained when the method of Heeringa & Van de Velde II is used."),
    
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We will
         visualize the effect of the normalization method of Heeringa & Van de
         Velde II. We start by visualizing the vowel spaces of the speakers on
         the basis of unnormalized Hertz frequencies:"),
      
      tags$ul(
        tags$li(HTML("Enter a <b>plot title</b>: 'Comparison of vowel 
                      spaces'")),
        tags$li(HTML("At <b>Time points to be shown</b> select 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'speaker'")),
        tags$li(HTML("At <b>Select colors</b> select all speakers. First select
                      the first speaker 'NMmj1' and hold down the left mouse
                      button, then drag the mouse over all the other
                      speakers.")),
        tags$li(HTML("At <b>Shape variable</b> not anything should be selected.
                      If a variable is selected, deselect it by holding the
                      Ctrl key (on a Apple computer the command key) and
                      clicking on it.")),
        tags$li(HTML("At <b>Panel variable</b> select 'region', and at <b>Select
                      panels</b> select all regions.")),
        tags$li(HTML("Check 'hull'.")),
        tags$li(HTML("Uncheck 'average'."))
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("For each
         region, it appears as if there are smaller triangles within larger
         triangles. How do you explain this?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("At
        <b>Normalization</b> choose 'Heeringa & Van de Velde (2021) II'.")),

      p(span(shiny::icon("question-circle"), class='Icon'), "What differences do
         you find?"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Try also 
        'Gerstman (1968)' and 'Lobanov (1971)'."),
      
      h2("Visualizing in 3D"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We will
         visualize the vowel system of 'NL-Randstad' in three dimensions. In
         order to obtain the 3D graph, do the following:"),
      
      tags$ul(
        tags$li(HTML("Enter as <b>plot title</b>: 'Vowel system of 
                      NL-Randstad'")),
        tags$li(HTML("At <b>Time points to be shown</b> select 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("At <b>Color variable</b> select 'vowel' and 'region'.")),
        tags$li(HTML("At <b>Select colors</b> select all vowels of 
                     'NL-Randstad'. First find 'NL-Randstad' and click on it.
                      Then press the shift key. While holding this key press the
                      arrow down key successively several times until all the
                      vowels of 'NL-Randstad' are selected. Then release the
                      shift key.")),
        tags$li(HTML("Check 'smooth trajectories'.")),
        tags$li(HTML("Check 'average'.")),
        tags$li(HTML("At the left of the graph select 'F3' at <b>z-axis</b>.")),
        tags$li(HTML("Check 'labels'.")),
        tags$li(HTML("Retain 'lines' checked.")),
      ),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Experiment
         with different values for <b>Angle x-axis</b> and <b>Angle z-axis</b>.
         For example, try 10° for the angle with the x-axis and 60° for the
         angle with the z-axis.")),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("The vowel with
         the largest F3 touches the 'roof', while the vowel with the smallest
         F3 has no line below it. Which vowel has the largest F3? Which vowel 
         has the smallest F3?")),

      h2("Measuring long-term formants"),
      
      p("Long-term formants are useful for speaker identification of speech
         samples. A long-term formant (F1, F2 or F3) of a speaker is calculated
         as the average formant value of the vowel types that were pronounced by
         the speaker. Normally, there are multiple realizations per vowel type.
         Therefore, the formant values of the realizations are
         averaged per type before averaging over the vowel types."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We will compare
         the four groups defined by the variables 'sex' and 'age'. Do the
         following:"),

      tags$ul(
        tags$li(HTML("Enter as <b>plot title</b>: 'LTFs across sex and age'")),
        tags$li(HTML("At <b>Time points to be shown</b> select 50%.")),
        tags$li(HTML("At <b>Scale</b> retain 'Hz', at <b>Normalization</b>
                      retain 'None'.")),
        tags$li(HTML("Check 'long-term formants'; this option is at the very
                      bottom.")),
        tags$li(HTML("At <b>Color variable</b> make sure that not any variable
                      is selected.")),
        tags$li(HTML("At <b>Shape variable</b> no variable should be
                      selected")),
        tags$li(HTML("At <b>Panel variable</b> select 'sex' and 'age'.")),
        tags$li(HTML("At <b>Select panels</b> select 'male old', 'male young',
                      'female old' and 'female young'.")),
        tags$li(HTML("Check 'spokes'.")),
        tags$li(HTML("Check 'ellipse'.")),
        tags$li(HTML("At <b>Confidence level</b> retain 0.95.")),
        tags$li(HTML("At the left of the graph check 'min/max'")),
        tags$li(HTML("At <b>max. x</b> enter: 2000.")),
        tags$li(HTML("Underneath the graph set the font size to 24."))
      ),
      
      p("The result should look like this:"),
      
      div(img(src = 'formant7.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Describe the
         differences between the four groups.")),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Click on 
         the button 'Table' below the graph in case you want to save the part of
         the data that was used for creating the graph. You can choose from two
         formats: txt and xlsx. You can download the graph by clicking on the
         button 'Graph'. Generating the file takes some time, so just wait. For
         more details about saving tables and graphs see at the end of the
         explanation of the Contours tab in this tutorial.")),

      br(),
      
      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous5", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next5"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$dynamics <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Vowel dynamics"),

      p(HTML("In order to measure vowel dynamics, two methods are implemented
         that were introduced by Fox and Jacewicz (2009): trajectory length 
         (<i>TL</i>) and spectral rate of change (<i>TL<sub>roc</sub></i>).")),
         
      p(HTML("Fox and Jacewicz (2009) measured <i>TL</i> as the sum of the
         lengths of the vectors that constitute a vowel formant trajectory,
         where the length of a vector is measured as the Euclidean distance
         between the coordinates (defined by f0 and/or F1 and/or F2 and/or F3)
         of the starting point and the end point of the vector.")),
      
      p(HTML("<i>TL<sub>roc</sub></i> is obtained by dividing the length of each
         vector by the size of the time interval spanned by that vector before
         adding the vector lengths together.")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
         'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
         you previously saved it. Open the file. The table will be shown. Then
         choose 'Dynamics' in the top navigation bar."),

      h2("Comparing dynamics of vowels"),
         
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We measure and
         visualize the dynamics of the vowels of NL-Randstad. Choose the
         following settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'Vowel dynamics of NL-Randstad'")),
        tags$li(HTML("<b>Scale:</b> retain 'Hz'.")),
        tags$li(HTML("<b>Method:</b> retain 'Fox & Jacewicz (2009) TL'.")),
        tags$li(HTML("<b>Select graph type:</b> retain 'Dot chart'.")),
        tags$li(HTML("<b>Size of confidence intervals:</b> retain '95%'.")),
        tags$li(HTML("<b>Use: </b> retain 'SE'.")),
        tags$li(HTML("<b>Variable:</b> select F1 and F2.")),
        tags$li(HTML("<b>Points:</b> 25, 38, 50, 62, 75.")),
        tags$li(HTML("<b>Var. x-axis:</b> select 'vowel'.")),
        tags$li(HTML("<b>Sel. categ.:</b> select all vowels.")),
        tags$li(HTML("<b>Color var.:</b> select nothing.")),
        tags$li(HTML("<b>Panel var.:</b> select 'region'.")),
        tags$li(HTML("<b>Sel. panels:</b> select 'NL-Randstad'.")),
      ),
      
      br(),
      div(img(src = 'dynamics1.png', style='display: block; margin-left: auto; margin-right: auto; height: 500px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Which vowels
         show the most dynamics? Why?")),

      h2("Dynamics of [ɛi] across regions and ages"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We compare the
         dynamics of the diphthong [ɛi] across the eight regions and the two age
         groups. Change the following settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'Dynamics of [ɛi] across regions and
                      ages'")),
        tags$li(HTML("<b>Var. x-axis:</b> select 'region'.")),
        tags$li(HTML("<b>Sel. categ:</b> select all regions.")),
        tags$li(HTML("<b>Color var.:</b> select 'vowel' and 'age'.")),
        tags$li(HTML("<b>Sel. colors:</b> select 'ɛi old' and 'ɛi young'.")),
        tags$li(HTML("<b>Panel var.:</b> deselect 'region'.")),
        tags$li(HTML("Check 'rotate x-axis labels'.")),
        tags$li(HTML("Underneath the graph change the font size from 22 to
                      16.")),
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("In which 
         regions is the [ɛi] pronounced with stronger dynamics? When comparing
         the younger speakers to the older speakers, what do you notice?")),
         
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Suggestions for
         further experimenting:"),
      
      tags$ul(
        tags$li(HTML("Add F3.")),
        tags$li(HTML("Select F1, F2 and F3 individually.")),
        tags$li(HTML("Use 'Fox & Jacewicz (2009) TL_roc' instead of 'Fox & 
                      Jacewicz (2009) TL'.")),
        tags$li(HTML("Use 'Bart chart' instead of 'Dot plot'.")),
        tags$li(HTML("Use different sizes for the confidence intervals, and try
                      both 'SD' and 'SE'.")),
      ),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Click on 
         the button 'Table' below the graph in case you want to save the part of
         the data that was used for creating the graph. You can choose from two
         formats: txt and xlsx. You can download the graph by clicking on the
         button 'Graph'. Generating the file takes some time, so just wait. For
         more details about saving tables and graphs see at the end of the
         explanation of the Contours tab in this tutorial.")),
      
      br(),

      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous6", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next6"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$duration <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Duration"),

      p("In this session we will focus on visualizing and comparing vowel 
         durations. We get to know the possibilities of this tab on the basis of
         two examples."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
         'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
         you previously saved it. Open the file. The table will be shown. Then
         choose 'Duration' in the top navigation bar."),
      
      h2("Comparing durations of vowels"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We visualize the
         durations of the vowels as pronounced by the speakers in the region
         'FL-east'. Choose the following settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'Vowel durations of FL-East'")),
        tags$li(HTML("<b>Normalization:</b> retain 'None'.")),
        tags$li(HTML("<b>Select graph type:</b> retain 'Dot chart'.")),
        tags$li(HTML("<b>Size of confidence intervals:</b> retain '95%'.")),
        tags$li(HTML("<b>Use: </b> retain 'SE'.")),
        tags$li(HTML("<b>Variable x-axis:</b> select 'vowel'.")),
        tags$li(HTML("<b>Sel. categories:</b> select all vowels.")),
        tags$li(HTML("<b>Color variable:</b> select 'sex' and 'age'.")),
        tags$li(HTML("<b>Select colors:</b> select 'female old' and 'female young'.")),
        tags$li(HTML("<b>Panel variable:</b> select 'region'.")),
        tags$li(HTML("<b>Select panels:</b> select 'FL-East'.")),
      ),
      
      br(),
      div(img(src = 'duration1.png', style='display: block; margin-left: auto; margin-right: auto; height: 500px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Compare the
         durations of older male speakers to those of the younger female
         speakers. What do you notice?")),
      
      p(HTML("Some speakers speak faster than others. Therefore, durations
         should be normalized within speakers. This can be done by Lobanov's 
         <i>z</i>-normalization. Negative normalized durations refer to
         relatively short vowel tokens, and positive values represent relatively
         long vowel durations.")),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Select 
        'Lobanov (1971)' at <b>Normalization</b>.")),

      p(span(shiny::icon("question-circle"), class='Icon'), HTML("What
         differences do you find compared to the previous results? What do you
         conclude?")),

      h2("Durations of [i] and [u] across regions"),       
       
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Try to
         create the graph below. Hint: use Lobanov (1971) as vowel duration
         normalization method, check 'rotate x-axis labels', and set font size
         at 16.")),
      
      div(img(src = 'duration2.PNG', style='display: block; margin-left: auto; margin-right: auto; height: 350px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Which area
         is found to be very distinct from the other areas? Apart from this 
         area, how do [i] and [u] durations generally relate to each 
         other in the graph?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Suggestions for
         further experimenting:"),
      
      tags$ul(
        tags$li(HTML("Use 'Bart chart' instead of 'Dot plot'.")),
        tags$li(HTML("Use different sizes for the confidence intervals using
                      'SD' or 'SE'.")),
      ),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Click on 
         the button 'Table' below the graph in case you want to save the part of
         the data that was used for creating the graph. You can choose from two
         formats: txt and xlsx. You can download the graph by clicking on the
         button 'Graph'. Generating the file takes some time, so just wait. For
         more details about saving tables and graphs see at the end of the
         explanation of the Contours tab in this tutorial.")),

      br(),

      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),

        actionButton("previous7", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next7"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })

  output$explore <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Explore"),

      p(HTML("In the tab 'Explore' relationships among speakers are calculated
         and visualized, and they can be related to sociolinguistic variables.
         In the tab we find two measures by which these relationships can be
         calculated: 'Euclidean' and 'Accdist'.")),
      
      p(HTML(" When using 'Euclidean' speakers <i>A</i> and <i>B</i> are
         compared by calculating the average Euclidean distance between the
         vowels of speaker <i>A</i> and the corresponding vowels of speaker
         <i>B</i>.")),
      
      p(HTML("When using 'Accdist' Huckvale's ACCDIST measure is used, which
         compares speakers <i>A</i> and <i>B</i> by correlating the mutual
         Euclidean distances among the vowels within speaker's <i>A</i> vowel
         space with the corresponding distances within speaker's <i>B</i> vowel
         space. The distance between the two speakers then is calculated as 1
         minus the correlation. If you want to read more about Huckvale's ACCDIST
         measure click "), 

        a("here", 
          href    = "http://markhuckvale.com/research/papers/icslp04.pdf", 
          style   = "cursor:pointer; text-decoration: none; outline: none;", 
          onclick = "'http://markhuckvale.com/research/papers/icslp04.pdf', 'popUpWindow', '_blank'); return false;", 
          target  = "_blank"
       ),
        
        HTML("in order to read his paper.")),

      p("Calculating Euclidean distances takes less computation time than
         calculating ACCDIST distances. However, as we will find below 
         'Euclidean' requires vowel formant normalization while 'Accdist' does
         not."),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
         'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
         you previously saved it. Open the file. The table will be shown. Then
         choose 'Explore' in the top navigation bar."),
      
      h2("Comparing northern and southern speakers"),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We compare
         speakers of 'NL-North' with those of 'NL-South'. Choose the following
         settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'NL-North versus NL-South'")),
        tags$li(HTML("<b>Time points to be included:</b> choose 25, 50 and 75.")),
        tags$li(HTML("<b>Include formants:</b> select 'F1' and 'F2'.")),
        tags$li(HTML("<b>Metric:</b> select 'Euclidean'.")),
        tags$li(HTML("<b>Scale:</b> retain 'Hz'.")),
        tags$li(HTML("<b>Normalization:</b> retain 'None'.")),
        tags$li(HTML("<b>Sel. vowels:</b> select all vowels.")),
        tags$li(HTML("<b>Sel. variable:</b> select 'region' and 'sex'.")),
        tags$li(HTML("<b>Sel. categories:</b> select 'NL-North male', 'NL-north
                      female', 'NL-South male' and 'NL-South female'.")),
        tags$li(HTML("<b>Explorative method:</b> select 'Cluster analysis'.")),
        tags$li(HTML("Retain 'UPGMA'.")),
      ),
      
      br(),
      div(img(src = 'explore1.png', style='display: block; margin-left: auto; margin-right: auto; height: 500px;'), style='overflow-x:auto;'),
      br(),

      p(span(shiny::icon("question-circle"), class='Icon'), HTML("View the 
         dendrogram. Which distinction is found to be most important: NL-north
         versus NL-South, or: male versus female? Consult also the 
         multidimensional scaling plot. You will obtain this plot by selecting
         'Multidimensional scaling' at <b>Explorative method:</b>.")),

      p("Both for cluster analysis and multidimensional scaling the 'explained
         variance' is given. For cluster analysis this is calculated as the
         squared correlation coefficient between the original inter-speaker
         distances and the distances among the speakers as implied by the
         dendrogram. For multidimensional scaling this is calculated as the
         squared correlation between the original inter-speaker distances and 
         the Euclidean inter-point distances of the two-dimensional plot. The
         explained variance varies between 0 and 1. The higher the explained
         variance, the better the method."),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Both for cluster
         analysis and for multidimensional scaling find out which method yields
         the highest 'explained variance'."),
      
      p("In order to reduce the effect of the male/female distinction, we will
         use 'ERB: Greenwood (1961)' as scale conversion method and 'Lobanov
         (1971)' as vowel formant normalization method. Using our data set we
         found in the normalization tab that this combination was one of the
         best according to all five evaluation methods."),
        
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Change the
         following settings as follows:"),
      
      tags$ul(
        tags$li(HTML("<b>Scale:</b> choose 'ERB: Greenwood (1961)'.</b> ")),
        tags$li(HTML("<b>Normalization:</b> choose 'Lobanov (1971)'.")),
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("View both the
         dendrogram and the multidimensional scaling plot. Choose the methods
         with the highest explained variance. How do the results compare to the
         previous results?")),

      p(HTML("Now we will use the ACCDIST measure. From this method it is known
         that it is largely uninfluenced by the individual characteristics of
         the speakers’ voices (see "),
         
        a("this book chapter", 
          href    = "https://link.springer.com/chapter/10.1007/978-3-540-74122-0_20", 
          style   = "cursor:pointer; text-decoration: none; outline: none;", 
          onclick = "'https://link.springer.com/chapter/10.1007/978-3-540-74122-0_20', 'popUpWindow', '_blank'); return false;",
          target  = "_blank"
        ),
        
         HTML("). Therefore, we apply this method to the original data, without
         using scale conversion and vowel formant normalization methods. Open a
         new tab in your browser and do the following:")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Open a new tab
         in your browser, enter 'visiblevowels.org' as web url and load
         'Van der Harst 2011.xlsx' again. Then go to  the 'explore' tab and 
         choose the following settings: "),

      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'NL-North versus NL-South'")),
        tags$li(HTML("<b>Time points to be included:</b> choose 25, 50 and 75.")),
        tags$li(HTML("<b>Include formants:</b> select 'F1' and 'F2'.")),
        tags$li(HTML("<b>Metric:</b> select 'Accdist'.")),
        tags$li(HTML("<b>Scale:</b> choose 'Hz'.")),
        tags$li(HTML("<b>Normalization:</b> choose 'None'.")),
        tags$li(HTML("<b>Sel. vowels:</b> select all vowels.")),
        tags$li(HTML("<b>Sel. variable:</b> select 'region' and 'sex'.")),
        tags$li(HTML("<b>Sel. categories:</b> select 'NL-North male', 'NL-north
                      female', 'NL-South male' and 'NL-South female'.")),
        tags$li(HTML("As clustering method choose 'UPGMA' and as
                      multidimensional scaling method choose 'Kruskal's'.")),
        tags$li(HTML("When viewing the multidimensional scaling plot check
                      'inv. Y' which will make your result comparable with the
                      previous result.")),
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Compare the
         results in the current tab with the results in the previous tab. What
         is the main similarity? Which of the two approaches would you prefer?
         Why?")),

      h2("Comparing the regions"),
      
      p(HTML("In the 'explore' tab it is also possible to compare groups of
         speakers to each other. This is realized by checking the option
         'summarize'. The groups are defined according to the categorical
         variables that are chosen under <b>Sel. variable</b> and by the
         categories of those variables that are selected under <b>Sel.
         categories</b>. For example, when the variables 'sex' and 'age' are
         selected, it is possible to compare the group of old male speakers with
         the group of young female speakers when the categories 'male old' and
         'female young' are selected.")),
      
      p(HTML("The distances between two groups is obtained on the basis of all
         speaker pairs with one speaker in one group and the other speaker in
         the other group. Assume group 1 with speakers <i>A</i>, <i>B</i> and
         <i>C</i>, and group 2 with speakers <i>X</i> and <i>Y</i>, then the
         distance is calculated as the average distance of the speaker pairs
         <i>AX</i>, <i>AY</i>, <i>BX</i>, <i>BY</i>, <i>CX</i> and
         <i>CY</i>.")),

      p(span(shiny::icon("exclamation-circle"), class='Icon'), "We will compare
         the eight regions to each other. Choose the following settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'Comparison of regions'")),
        tags$li(HTML("<b>Time points to be included:</b> choose 25, 50 and 75.")),
        tags$li(HTML("<b>Include formants:</b> select 'F1' and 'F2'.")),
        tags$li(HTML("<b>Metric:</b> select 'Accdist'.")),
        tags$li(HTML("<b>Scale:</b> choose 'Hz'.")),
        tags$li(HTML("<b>Normalization:</b> choose 'None'.")),
        tags$li(HTML("<b>Sel. vowels:</b> select all vowels.")),
        tags$li(HTML("<b>Sel. variable:</b> select 'region'.")),
        tags$li(HTML("<b>Sel. categories:</b> select all regions.")),
        tags$li(HTML("As clustering method choose 'UPGMA' and as
                      multidimensional scaling method choose 'Kruskal's'.")),
        tags$li(HTML("Check 'summarize'.")),
        tags$li(HTML("When viewing the multidimensional scaling plot check
                      'X⇄Y' and check 'inv. Y'."))
      ),
      
      p(span(shiny::icon("question-circle"), class='Icon'), "In the section
         about the data set in this tutorial the following map was shown:"),
      
      img(src = 'map.png', class = "center"),
      
      p("Does the multidimensional scaling plot resemble the geographic
         distribution of the regions? Which region(s) are - given the map -
         'located off place'?"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "As a next step
         we will distinguish between the two age groups for each region. Change
         the following settings as follows:"),
      
      tags$ul(
        tags$li(HTML("<b>Plot title:</b> 'Comparison of regions and ages'")),
        tags$li(HTML("<b>Sel. variable:</b> add the variable 'age'. Hold the
                      Ctrl key (when using an Apple computer the command key)
                      and click on 'age'.")),
        tags$li(HTML("<b>Sel. categories:</b> select all 16 categories.")),
        tags$li(HTML("As font size choose 12."))
      ),

      p(span(shiny::icon("question-circle"), class='Icon'), HTML("The difference
         between the older speakers and the younger speakers of a region
         reflects the change of the accent of that region. In which regions has
         the accent changed the most?")),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Suggestions for
         further experimenting:"),
      
      tags$ul(
        tags$li(HTML("Include also F3.")),
        tags$li(HTML("When 'Multidimensional scaling' is selected, the option
                      't-SNE' (t-distributed stochastic neighbor embedding)
                      becomes available. t-SNE is a machine learning algorithm
                      for visualization developed by Laurens van der Maaten
                      and Geoffrey Hinton. Click "), 
                      
                a("here", 
                  href    = "https://en.wikipedia.org/wiki/T-distributed_stochastic_neighbor_embedding", 
                  style   = "cursor:pointer; text-decoration: none; outline: none;",
                  onclick = "'https://en.wikipedia.org/wiki/T-distributed_stochastic_neighbor_embedding', 'popUpWindow', '_blank'); return false;",
                  target  = "_blank"
                ),
                
                HTML("for the Wikipedia article about t-SNE. Usually the results
                      of this method explain the least amount of variance in
                      the original inter-speaker distances. However, the results
                      of this method may reveal patterns that remain invisible
                      in the results that are obtained by using the other
                      methods. Experiment with t-SNE. Be aware that this is a
                      stochastic method: each time you run this method the
                      results are different.")),
      ),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Click on 
         the button 'Table' below the graph in case you want to save the part of
         the data that was used for creating the graph. You can choose from two
         formats: txt and xlsx. You can download the graph by clicking on the
         button 'Graph'. Generating the file takes some time, so just wait. For
         more details about saving tables and graphs see at the end of the
         explanation of the Contours tab in this tutorial.")),

      br(),

      splitLayout
      (
        align = "center", cellWidths = c("110px", "110px"),
        
        actionButton("previous8", HTML("&#8592; Previous"), width = "100%"),
        actionButton("next8"    , HTML("Next &#8594;")    , width = "100%")
      )
    )
  })
  
  output$evaluate <- renderUI(
  {
    fluidPage(
      class = "Content",

      h1("Evaluate"),

      p("Formant plots can be made in the 'Formants' tab. In that tab you have
         the possibility to choose a scale conversion method and a speaker vowel
         formant normalization method."),
      
      p("A scale conversion method changes the scale of the measurements. Scale
         conversion methods make the measurements logarithmic to a greater or
         lesser extent. If the formant measurements of the data set that you
         upload in Visible Vowels are in Hz, they can correctly be converted to
         9 different scales."), 

      p("Speaker vowel formant normalization is a technique that aims to
         minimize variation introduced by anatomic differences among speakers
         while preserving phonemic and sociolinguistic variation. Anatomic
         differences may be the result of differences in age, gender and
         physiological makeup (see Van der Harst 2011, p. 108 ff.). In Visible
         Vowels 16 speaker normalization methods are available."),
      
      p("The document ", 
        
        a("here", 
          href   = "https://www.visiblevowels.org/visvow.pdf", 
          target = "_blank"
        ),
        
        "describes how the scale conversion methods and the normalization 
         methods are implemented."),

      p("In the 'Formants' tab you can combine any normalization method with any
         scale conversion method. With the 'Evaluate' tab you can find the
         combination of a scale conversion method and a speaker normalization
         procedure that works best for your data set."),

      h2("Evaluation of methods"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), "Go to the tab
        'Load file', click on 'browse' and find 'Van der Harst 2011.xlsx' where
        you previously saved it. Open the file. The table will be shown. Then
        choose 'Evaluate' in the top navigation bar. Choose the following
        settings:"),
      
      tags$ul(
        tags$li(HTML("<b>Time points to be included:</b> select 25%, 50% and
                      75%.")),
        tags$li(HTML("<b>Normalization based on:</b> retain the 50% point.")),
        tags$li(HTML("<b>Anatomic var(s):</b> selected the variables 'sex' and
                      'age'. This is in line with Van der Harst (2011) who
                      considered the same variables as anatomic.")),
        tags$li(HTML("<b>Socioling. var(s):</b> choose the variable 'region';
                      this again is in line with Van der Harst (2011).")),
        tags$li(HTML("Click on <b>Go!</b> A progress bar will appear. 
                      Calculating the evaluation measures will take some time,
                      so have meanwhile a cup of coffee."))
      ),
        
      p(HTML("After the calculation of the evaluation measures has finished, you
         can use the options that are found underneath the table. For now, 
         retain the default options, i.e. 'Evaluate' under <b>Choose</b>,
         'Fabricius et al. (2009' under <b>Author</b> and 'equalize vowel space
         areas' under <b>Method</b>.")),

      br(),
      div(img(src = 'normalization1.png', style='display: block; margin-left: auto; margin-right: auto; height: 50px;'), style='overflow-x:auto;'),
      br(),
      
      p("The evaluation results are presented as a table where the columns
         represent the scale conversion methods and the rows the normalization
         procedures. Each score is shown on a background with a color somewhere
         in between turquoise and yellow. The more yellow the background is, the
         better the result."),
      
      p(HTML("When using the options under <b>Choose</b> and <b>Author</b> 
         results of other tests can be obtained as well. For some tests larger
         scores represent better results, and for other tests smaller scores
         represent better results. The background color always helps you out:
         the best scores have a yellow background.")),
      
      p(span(shiny::icon("question-circle"), class='Icon'), "Look at the table
         that you have just obtained. Which combination of scale conversion
         method and speaker normalization method has the best score?"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Play around
         with the other options for <b>Author</b> and <b>Method</b>. For each
         combination of options find the 'winning' combination of conversion
         method and normalization method. Describe the differences that you
         found for the different (combinations of) options.")),
      
      h2("Comparison of methods"),
      
      p("Some scale conversion methods may be very similar, for example, Bark I,
         II and III, or mel I and II. Likewise, we may expect that some 
         normalization methods are very similar, for example, Labov I and II or
         Nearey I and II."),

      p("In the previous section we searched for the 'winning' combination of a
         scale conversion method and a normalization method when evaluating the
         methods. The results we obtained in that section are put into
         perspective in this section. When, for example, 'bark I' and 'bark III'
         are found to be very related, it does not matter so much whether you
         choose 'bark I' or 'bark III'."),
      
      p(HTML("In order to get an idea how methods are related to each other and
         to find out whether there are groups of strongly related methods, you
         can select 'Compare' under <b>Choose</b>. Then a dendrogram is shown,
         which is a tree structure that shows the relationships among the 
         methods.")),
      
      p("The relationship between two methods - either scale conversion methods
         or normalization methods - is found by correlating the formant
         measurements converted by the one method with the same formant 
         measurements converted by the other method. Next, the distance between
         the two methods is calculated as 1 - correlation. This distance is
         calculated for any pair of methods."),
      
      p("On the basis of these distances the methods are clustered, i.e. similar
         methods are grouped in groups called clusters. The algorithm we choose
         for doing the clustering is known as 'group average clustering', a
         popular and intuitive method where the distance between two clusters is
         defined as the average distance between each point in one cluster to
         every point in the other cluster. The result of the clustering is
         visualized as a dendrogram"),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Select
        'Compare' under <b>Choose</b>, and retain 'Scaling' under 
         <b>Conversion</b>.")),

      br(),
      div(img(src = 'normalization2.png', style='display: block; margin-left: auto; margin-right: auto; height: 50px;'), style='overflow-x:auto;'),
      br(),

      p("The dendrogram you obtained looks like a tree in which the methods are
         the leaves. The shorter the route when 'travelling' from one method to
         another over the tree structure, the more related they are. For
         example, it is easy to travel from 'bark I' to 'bark III', so they are
         very related. However, travelling from 'bark I' to 'Hz' requires a much
         longer route, these methods are much less related to each other."),
      
      p(span(shiny::icon("exclamation-circle"), class='Icon'), HTML("Select
        'Normalization' under <b>Conversion</b>.")),
      
      br(),
      div(img(src = 'normalization3.png', style='display: block; margin-left: auto; margin-right: auto; height: 50px;'), style='overflow-x:auto;'),
      br(),
      
      p(span(shiny::icon("question-circle"), class='Icon'), HTML("Which
         groups of normalization methods do you find? Which methods are
         relatively similar to each other?")),

      p(HTML("For more technical details about the normalization tab, click on the &nbsp;"), 
        span(shiny::icon("info-circle"), style='color: #2c84d7; font-size:
        80%;'), HTML("&nbsp; in the upper left corner of the normalization tab.")),
      
      br(),

      splitLayout
      (
        align = "center", cellWidths = "110px",
        actionButton("previous9", HTML("&#8592; Previous"), width = "100%")
      )
    )
  })
}

shinyApp(ui, server)
