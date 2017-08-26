# Level Functions ----------------------
# Input Level Functions
levelLabel <- function(lflag, subtractMod = 0) {
  switch(lflag - subtractMod,
         "level_one",
         "level_two",
         "level_three",
         "level_four",
         "level_five",
         "level_six",
         "level_seven")
  #Call: levelLabel(level_flag())
  #  Or: levelLabel(2)
}

# Check if we should render
checkRender <- function(inputLevel, pflag) {

  check <- FALSE

  if (!is.null(inputLevel)) {
    if (pflag == TRUE & inputLevel != "") {
      check <- TRUE
    }
  }

  return(check)
}

# Get options from framework
getOptions <- function(q_data) {
  # Check if its terminal node
  node_or_chart <- if (!is.na(q_data[["node_targets"]])) {
    "node_targets"
  } else {
    "chart"
  }

  setNames(c("", makeList(q_data,node_or_chart)),
           c("", makeList(q_data,"options")))
}

# Turn node_target and chart into lists
makeList <- function(q_data, colName) {

  unique(q_data[[colName]]) %>%
    strsplit(",") %>%
    flatten() %>%
    map(trimws)

}
