{-# LANGUAGE QuasiQuotes #-}

module GTF.Pages.Home (content) where

import CommonPrelude
import GTF.Pages.Helpers (djot)
import GTF.Pages.Layout (PageMeta (..), plainLayoutWithMeta)
import GTF.Pages.Partials.Nav (navbar)
import GTF.URL (UrlPath (UrlPath))
import Lucid.Base (Html, toHtmlRaw)
import Lucid.Html5

content :: Html ()
content = plainLayoutWithMeta
  PageMeta
    { pageTitle = "home"
    , pageDescription = Just "Gideon's corner of the internet"
    , pageKeywords = Nothing
    }
  $ div_ [class_ "content-container"]
  $ main_ [class_ "page-home content-container"]
  $ do
    header_ [class_ "home-page-header"] $ do
      h1_ [class_ "brand"] "ἄπειροv"
    navbar (UrlPath "/")
    section_ [class_ "bio"]
      $ toHtmlRaw
        [djot|
      |]
    img_ [src_ "https://s.turbifycdn.com/aah/paulgraham/index-21.gif", alt_ "keyboard with archlinux slate"]
    toHtmlRaw
      [djot|
      |]