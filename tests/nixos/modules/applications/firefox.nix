# Import the test helper that provides the testing framework
import ./make-test-python.nix ({ pkgs, ... }: {
  name = "firefox-test";
  
  # Define the test machine configuration
  nodes.machine = { config, pkgs, ... }: {
    imports = [
      ../nixos/modules/applications/firefox.nix
    ];
    
    # Enable the Firefox module
    mySystem.programs.firefox.enable = true;
    
    # Add a user for testing
    users.users.testuser = {
      isNormalUser = true;
      uid = 1000;
    };
  };
  
  # The actual test script (Python)
  testScript = ''
    # Start the machine and wait for it to be ready
    machine.start()
    machine.wait_for_unit("multi-user.target")
    
    # Check that Firefox is installed
    machine.succeed("which firefox")
    
    # Verify Firefox preferences are set correctly
    machine.succeed(
      "su - testuser -c 'grep -q \"widget.use-xdg-desktop-portal.file-picker\" ~/.mozilla/firefox/*default*/prefs.js'"
    )
  '';
})
