#' Create standard analysis template for RStudio project
#'
#' @param path path of the new project
#' @param include_analysis_for_publication additional Analysis for publication folder
#' @param use_renv should renv be used?
#' @param include_gitignore should a gitingore file be created
#' @param ... additional parameters, currently not used
#'
#' @return no return values, just the folders and README are created
#' @importFrom utils installed.packages
#' @export
standard_analysis <- function(
    path,
    include_analysis_for_publication,
    use_renv,
    include_gitignore,
    ...) {
  # ensure that the path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  
  # create folder structure
  
  dir.create(paste0(path, "/00_Pre_registration"))
  
  dir.create(paste0(path, "/01_Data"))
  dir.create(paste0(path, "/01_Data/01_Raw"))
  dir.create(paste0(path, "/01_Data/02_Clean"))
  dir.create(paste0(path, "/01_Data/03_Species_list"))
  
  dir.create(paste0(path, "/02_Analysis"))
  dir.create(paste0(path, "/02_Analysis/01_Scripts"))
  dir.create(paste0(path, "/02_Analysis/02_Results"))
  dir.create(paste0(path, "/02_Analysis/03_Figures"))
  dir.create(paste0(path, "/02_Analysis/04_Tables"))
  
  dir.create(paste0(path, "/03_Manuscript"))
  dir.create(paste0(path, "/03_Manuscript/01_Text"))
  dir.create(paste0(path, "/03_Manuscript/02_Final_figures"))
  dir.create(paste0(path, "/03_Manuscript/03_Supplementary_material"))
  
  dir.create(paste0(path, "/04_Presentation"))
  
  dir.create(paste0(path, "/05_Communication"))
  dir.create(paste0(path, "/05_Communication/01_Internal_comm"))
  dir.create(paste0(path, "/05_Communication/02_External_comm"))
  
  dir.create(paste0(path, "/06_Misc"))
  
  if (include_analysis_for_publication) {
    dir.create(paste0(path, "/07_Analysis_for_publication"))
    dir.create(paste0(path, "/07_Analysis_for_publication/01_Scripts"))
    dir.create(paste0(path, "/07_Analysis_for_publication/02_Results"))
    dir.create(paste0(path, "/07_Analysis_for_publication/03_Figures"))
    dir.create(paste0(path, "/07_Analysis_for_publication/04_Tables"))
  }
  
  # create a .gitignore file
  if (include_gitignore) {
    gitignore_content <- c(
      ".Rproj.user",
      ".Rhistory",
      ".RData",
      ".Ruserdata",
      "01_Data",
      "*/02_Results",
      "*/03_Figures",
      "*/04_Tables",
      "03_Manuscript/02_Final_figures",
      "04_Presentation",
      "05_Communication",
      "06_Misc"
      "*.html"
    )
    
    gitignore_content <- paste0(gitignore_content, collapse = "\n")
    writeLines(gitignore_content, con = file.path(path, ".gitignore"))
    
  }
  
  # create a readme
  content <- c(
    "# Readme",
    "## Project title",
    "Provide a short title for your project",
    "## Badges/Project Status",
    "State if the poject is mantained,  if it has been published and associated DOIs"
    "## About this work",
    "Please give an overview what you do in this project and how to navigate it.",
    "## Usage and Contribution",
    "Please provide information on how to navigate folders,use the code and how to contribute to the project if that's possible.",
    "## Data",
    "Provide an overview of the data and data structures you are using in this project. If you are using data from a public repository, please provide the link to the data.",
    "### Variables", "Describe variable names, units and collection methods including relevant dates and locations",
    "### Data cleaning and transformations", "Describe the data cleaning and transformations steps you have taken",
    "## Authors and contributors", "Provide authors and contributors names and contact information. State a corresponding author",
    "",
    "## Citation", "Please provide guidelines on how your work should be cited. If you have a DOI, please provide it here.",
    "## Licenses", "State under what licenses your work will be distributed.Please note that the licenses for the data and the code are not included in this template. Please add them to the respective folders."
  )
  content <- paste0(content, collapse = "\n")
  writeLines(content, con = file.path(path, "README.md"))
  
  # initialise renv
  if (use_renv) {
    if (requireNamespace("renv", quietly = TRUE)) {
      renv::init(
        project = normalizePath(path),
        bare = TRUE
      )
    } else {
      warning("renv couldn't be used as the `renv` package is not installed. If you want to use renv, please first install it with `install.packages('renv')`")
    }
  }
}
