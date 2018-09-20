## Poker Score
Utility to score two poker hands against each other and find a winner

### To Run
Edit the two sets of cards in score.rb to reflect whichever hands you want to 
score against each other. 

Card values range from 2 to 14:

    * 2 - 10 are number cards
    * 11 - 14 are face cards
    * 14 = high ace

Run from the main directory using the following command.

```
ruby -I . lib/pokerscore/score.rb
```

#### To Test
Run tests from the main directory using the following command.

```
ruby -I . tests/test_name.rb 
```

The -I flag sets the $LOADPATH directory.
