# Development Log

#### Monday 20 Apr

Feeling confident that I have written 95% of my Terminal App, I am met with resounding positivity on selection of my assignment - One, a Ruby version of UNO - the card game. 

I had high hopes of including an AI player in my app so the user did not have to play another user. Zeb rightly suggested this was going to be too much work and I should make my app simpler by not including an AI. I agreed and was happy to start work on the documentation and adjusting my code to not include any computer players.

Started writing the documentation necessary, including control flow diagrams, Trello board, and attempt to write some integrated testing for my program. This is where I ran into problems. I was unsure how they were supposed to be implemented so I went back and studied up on how Zeb did it in his tutorial on error handling.

#### Tuesday 21 Apr

Needing some assistance on how the testing code will interact with my code, I ask Zeb for some assistance. This was where the panic set in.

He looked at my code and saw a bunch of global variables with a structure more inline with 'C' programming than OOP. He declared that testing this program was extremely hard and I should re-write it with a more OOP approach. More classes, modules and objects. To do this, I've had to drop some functionality from my original concept to a simpler UNO game closer to the original. I now have to re-do all the documentation, Trello board, testing, and code. I made a start with some simple classes and managed to get a few tests written to confirm their viability. I have continued on coding and testing, commiting to Github whenever I get the chance and updating the documentation. 

#### Wednesday 22 Apr

After sleeping on it but not really sleeping that much, I have a basic structure in my head for how the rest of the program will look. I've done the classes and the foundation on which to build. I'm going to divide the main build into 5 parts.

The Splash Screen - User views rules, quits, or starts the game

Initialization Module - User chooses number of players, player creation, deck creation, deal cards

Pre Turn Module - Methods for any skip, reverse, pickup 2, pickup 4 cards played from previous user and applies correct logic

Turn Module - methods for card options the player has and user input as which card to play or draw

End Turn Module - methods for testing the winner scenario and any end turn logic.

The whole thing will be then called from the main program called One which requires everything else and has the turn loop.

I have written up the control flow diagram to help me visualise the final structure.



#### Thursday 23 Apr

I have been manually testing as I went and continue to do so. I have also updated the Trello board to reflect the build in broad strokes. 

I have written the rules down in a separate text file that I will include in the final help file as well as a separate file in the repo.

I have just started to understand how OOP should be structured. It's starting to make more sense to me now and I feel like I will be able to structure programs better in future. 

I continue to code, testing as I go whenever a new feature / method is introduced. Today, I managed to get the main turn loop working and almost have a basic working program



#### Friday 24 Apr

Continuing to develop the documentation. I finished the implementation plan and the statement purpose and scope.

I have reworked some of the code to simplify the main file and put more logic and methods into different classes. This makes the code more hierarchical and easier to test. I have implemented some test/unit tests and these seem to work ok.

I finished the splash-screen module and transferred the rules text into the program. I have also fixed a reverse bug that was not functioning properly.

I have included a  TTY-font gem to make the winner screen a bit more special.

I have updated the Trello board to record the work I have done.

#### Saturday 25th Apr

Game is now working as intended. Continuing to test as I go.

Added more documentation in features, help file.

Added the splash screen functionality. Included some validations for the options in the splash screen inputs.

Added Cmd line arguments -h for help, -s to skip the splash screen, -mp to change the maximum_num_player variable. 

Added validation to the Cmd arguments

Was not able to correctly validate the -mp value. I have left user feedback to use this at own risk. 

#### Sunday 26th Apr

Included gems - tty-box, tty-font

I desperately tried to include tty-box to display the cards the player has in their hand but was unable to get it to work the gem only wants to draw boxes in a vertical fashion. I did not want this as I wanted the user to be able to see their hand without scrolling down. I left it to display the match card however as this only required one box.

I tried installing tty-table to list them in a table but was unable to get this to work

Was able to get tty-font working to make the winner screen a bit more special.

#### Monday 27th Apr

Had another go at tty-table to display the cards the player has in their hand in a nicer way and was able to get it to work by creating the array first and then applying it to the tty-table. However, the game crashes when the player draws enough cards to reach the end of the screen so I abandoned it.

finalising trello board. Posting all trello screenshots. Sharing the trello board.

Created some more test/units. Feeling more confident about test/unit now. I think the game is structured well enough to test quite a lot of features.

Finalising the documentation to include the cmd_arguments. 

Finalising the help file and testing the installation instructions.
All in all, I'm happy with what I've achieved. I think my code is much better now than what it was without Zebs advice. I feel like I understand the concepts of OOP and the ability to run tests. I didn't get a handle on the rspec tests and ended up abandoning them and sticking with the test unit tests. I will try to get a handle on rspec in future. I will also continue to develop my One program and put in extra features I was unable to include for the assignment.

