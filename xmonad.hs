-- xmonad configuration file for use with the GNOME desktop environment
--
import XMonad
import XMonad.Config.Gnome

-- no idea what stuff comes from which module
--
 
import Control.Monad (liftM)
-- LAYOUTS
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Circle
import XMonad.Layout.Spiral
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances hiding (FULL, NBFULL, NOBORDERS, SMARTBORDERS)
import XMonad.Layout.Reflect

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.GridSelect
-- WINDOW RULES
import XMonad.ManageHook
-- KEYBOARD & MOUSE CONFIG
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
-- STATUS BAR
import XMonad.Hooks.DynamicLog hiding (xmobar, xmobarPP, xmobarColor, sjanssenPP, byorgeyPP)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Dmenu
import System.IO (hPutStrLn)
import XMonad.Util.Run (spawnPipe)
import Data.List
-- MULTIMONITOR
import XMonad.Actions.PhysicalScreens
import Data.Maybe (fromMaybe)
-- UTILITIES
import XMonad.Prompt
import XMonad.Prompt.AppendFile

defaultLayouts = onWorkspace (myWorkspaces !! 8) ((avoidStruts fullScreen) ||| fullScreen)
               $ avoidStruts (mkToggle (single REFLECTX) $ mkToggle (single MIRROR) ( tiled  ||| tiledSpace ||| goldenSpiral ||| Circle ||| mosaic )) ||| fullScreen
        where
                tiled            = spacing 5 $ ResizableTall nmaster delta ratio []
                tiledSpace       = spacing 60 $ ResizableTall nmaster delta ratio []
                fullScreen       = noBorders(fullscreenFull Full)
                mosaic           = spacing 5 $ MosaicAlt M.empty
                goldenSpiral     = spacing 5 $ spiral ratio
		nmaster = 1
		delta = 5/100
		ratio   = toRational (2/(1 + sqrt 5 :: Double))

myWorkspaces = clickable $
                ["^i("++myIconsDir++"alpha.xpm) alpha"
                ,"^i("++myIconsDir++"beta.xpm) beta"
                ,"^i("++myIconsDir++"gamma.xpm) gamma"
                ,"^i("++myIconsDir++"delta.xpm) delta"
                ,"^i("++myIconsDir++"epsilon.xpm) epsilon"
                ,"^i("++myIconsDir++"stigma.xpm) stigma"
                ,"^i("++myIconsDir++"zeta.xpm) zeta"
                ,"^i("++myIconsDir++"eta.xpm) eta"
                ,"^i("++myIconsDir++"theta.xpm) theta"]
        where clickable l     = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                                    (i,ws) <- zip [1..] l,
                                    let n = i ]

myIconsDir      = "/home/immo/.xmonad/icons/"


main = do
   xmonad $ gnomeConfig 
      {  modMask = mod4Mask -- use windows key as modifier key
      ,  borderWidth = 4
      ,  normalBorderColor = "#555555"
      ,  focusedBorderColor = "#61AEFD"
      ,  layoutHook = smartBorders(defaultLayouts)
      ,  manageHook = manageHook gnomeConfig <+> manageDocks
      ,  startupHook = spawn "~/.xmonad/startup.sh"
      }
      `additionalKeys`
      [ 
        ((mod4Mask .|. shiftMask , xK_semicolon), viewScreen 0 )
      , ((mod4Mask .|. shiftMask .|. controlMask , xK_semicolon), sendToScreen 0 )
      , ((mod4Mask .|. shiftMask , xK_comma), viewScreen 1 )
      , ((mod4Mask .|. shiftMask .|. controlMask , xK_comma), sendToScreen 1 )
       
      ]
