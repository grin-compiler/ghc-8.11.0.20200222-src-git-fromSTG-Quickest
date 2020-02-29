import Test.Cabal.Prelude
main = cabalTest $
    -- This repository contains a Cabal-1.18.0.0 option, which would
    -- normally would satisfy the repository, except for v2-build's
    -- extra constraint that setup Cabal must be 1.20.  If we don't
    -- have a choice like this available, the unsatisfied constraint
    -- won't be reported.
    --
    -- Due to #415, the lower bound may be even higher based on GHC
    -- version
    withRepo "repo" $ do
        -- Don't record because output wobbles based on installed database.
        recordMode DoNotRecord $ do
            fails (cabal' "v2-build" []) >>=
                assertOutputContains "Setup.hs requires >="
