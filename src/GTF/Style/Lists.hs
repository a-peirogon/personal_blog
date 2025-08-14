module GTF.Style.Lists (stylesheet) where
import Clay
import CommonPrelude ((<>))

stylesheet :: Css
stylesheet = do
  (ul <> ol) ? textAlign start

  ul # ".page-list" ? do
    listStyleType upperRoman
    padding (em 0) (em 0) (em 0) (em 0)

    li ? do

      lastChild & marginBottom none

      -- before & content (stringContent "§ ")

    ".table-of-contents" ** ol ? paddingLeft (em 1.2)

    ".table-of-contents" |> ol ? do
      listStyleType decimal

    ol ? do
      listStyleType lowerAlpha

    ol ? do
      listStyleType lowerRoman

  body ? do
    a ? do
      textDecoration none
      color "#900"
