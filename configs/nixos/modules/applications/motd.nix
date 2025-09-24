{
  config,
  lib,
  ...
}:
{
  options.myNixos.users.motd.enable =
    lib.mkEnableOption ''Message of the day shown to users when they log in.'';

  config = lib.mkIf config.myNixos.users.motd.enable {
    users.motd = ''
            ==[ THE CODE OF THE INNER SENTINEL ]==

            I. Virtue is the telos.
            All tools, skills, and victories serve it—or are discarded.
            Power, knowledge, emotion, even suffering are just fuel or obstacles on the path.

            II. Integrity is law.
            No lying, especially to myself.
            Convenience never outranks coherence.

            III. Power is a test, not a trophy.
            Use it cleanly. Answer for it fully.

            IV. Silence is sacred.
            In a loud world, depth is found in stillness. I listen to understand, not just to reply.

            V. I do not kneel to comfort.
            Ease is the slow rot of purpose. Discomfort is proof of motion.

            VI. I rule hunger, fear, and applause.
            They are tools, not masters. I am not a slave to craving or cowardice.

            VII. Childhood is sacred.

            VIII. I protect the space for doubt.
            Certainty untested is just a mask for insecurity and fear of meeting your true self.

            IX. I speak with discipline.
            Thoughts arrive fast. Wisdom is knowing which to hold, and when to listen instead.

            X. I walk alone, but not apart.
            Community is chosen, not inherited. Brotherhood is earned.

            XI. I do not abuse the voiceless.
            All life deserves restraint. Respect must be earned—but abusing earns me nothing.
            My strength shows in where I hold back.

            XII. I garden my thoughts.
            Impulse is not a compass. Desire is not a command. I trace and understand the root of my thoughts.
            Clarity is the blade. Discipline is the hand.
            Respond with intention.

            XIII. Death awaits. So I live.
            Every moment is unrepeatable.
            Not in panic, but in presence.



                     O_      __)(
             ,'  `.   (_".`.
            :      :    /|`
            |      |   ((|_  ,-.
            ; -   /:  ,'  `:(( -\
           /    -'  `: ____ \\\-:             I hope
          _\__   ____|___  \____|_
         ;    |:|        '-`      :              you find
        :_____|:|__________________:
        ;     |:|                  :      clarity and peace!
       :      |:|                   :
       ;______ `'___________________:
      :                              :
      |______________________________|
       `---.--------------------.---'
           |____________________|
           |                    |
           |____________________|
           |SSt                 |
         _\|_\|_\/(__\__)\__\//_|(_
         |     /  /   /    /   \    |
          \__/\__/\__/\__/\__/\__/
          https://www.asciiart.eu/comics/peanuts
          
    '';
  };
}
