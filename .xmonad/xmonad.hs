-- http://xmonad.org/xmonad-docs/xmonad/index.html
-- http://xmonad.org/xmonad-docs/xmonad-contrib/index.html
import System.IO
import qualified Data.Map as M

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W


myWorkspaces =
    [ "web [1]"
    , "mail [2]"
    , "chat [3]"
    , "term [4]"
    , "virt [5]"
    , "music [6]"
    , "play [7]"
    , "gimp [8]"
    , "code [9]" ]

myTerminal = "urxvt"

myFocusedBorderColor = "orange"

myModMask = mod1Mask

myKeys x =
    [ ((modMask x .|. shiftMask, xK_s), spawn "gnome-screensaver-command -l")
    , ((modMask x, xK_equal), spawn "amixer set 'Master' 5%+")
    , ((modMask x, xK_minus), spawn "amixer set 'Master' 5%-")
    , ((modMask x, xK_z), spawn "rhythmbox-client --no-present --previous")
    , ((modMask x, xK_x), spawn "rhythmbox-client --no-present --play-pause")
    , ((modMask x, xK_c), spawn "rhythmbox-client --no-present --next")
    , ((modMask x, xK_f), spawn "google-chrome")
    , ((modMask x, xK_g), spawn "gvim")
    , ((modMask x, xK_d), spawn "nautilus --no-desktop ~")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    ]
myKeyMap x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

myLayoutHook = avoidStruts
               $ smartBorders
               $ onWorkspace "gimp [8]" gimpLayout
               $ onWorkspace "chat [3]" pidginLayout
               $ (Tall 1 (3/100) (1/2) ||| Full)
    where
      gimpLayout   = withIM (0.11) (Role "gimp-toolbox")
                     $ reflectHoriz
                     $ withIM (0.15) (Role "gimp-dock") Full
      pidginLayout = reflectHoriz
                     $ withIM (0.15) (Role "buddy_list") Grid ||| Full

myManageHook =
    composeAll
    [ isFullscreen --> doFullFloat -- make full-screen windows work
      -- launch certain programs only on certain workspaces
    , className =? "Pidgin"    --> doF (W.shift "chat [3]")
    , className =? "Skype"     --> doF (W.shift "chat [3]")
    , className =? "Rhythmbox" --> doF (W.shift "music [6]")
    , className =? "Gimp"      --> doF (W.shift "gimp [8]")
    ] <+> manageHook defaultConfig

-- logging for xmobar to use
myLogHook h = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h }

-- xmobar styling
myPP =
    xmobarPP
    { ppCurrent         = xmobarColor "orange" ""
    , ppVisible         = xmobarColor "#B0B000" ""
    , ppHidden          = xmobarColor "#B0B0B0" ""
    , ppHiddenNoWindows = xmobarColor "#606060" ""
    , ppUrgent          = xmobarColor "orange" ""
    , ppSep             = "   "
    , ppWsSep           = "  "
      -- This centers the window title, but fails when there's no window
    , ppTitle           = wrap "}" "{" . xmobarColor "orange" ""
    }

main = do
  xmproc <- spawnPipe "xmobar"  -- start xmobar
  xmonad $ defaultConfig
             { manageHook = myManageHook
             , layoutHook = myLayoutHook
           --, borderWidth = myBorderWidth
           --, normalBorderColor = myNormalBorderColor
             , focusedBorderColor = myFocusedBorderColor
             , terminal   = myTerminal
             , modMask    = myModMask
             , keys       = myKeyMap
             , workspaces = myWorkspaces
             , logHook    = myLogHook xmproc
           --, focusFollowsMouse = False
	     }
