# Module Loader

This directory contains the `module-loader` library, which provides functionality for dynamically
loading NixOS modules from a directory.

By dynamically loading NixOS modules, I literally mean a plug-and-play implementation: just drop a
NixOS module anywhere within the directory structure where the module lives, and the flake will pick
it up on the fly next time you rebuild your flake.

I also provide a configurable `exlcudedPaths` list to blacklist any modules or directories you want
to prevent to be automatically imported by this module.

## Directory Structure

```shell
lib
└── module-loader
    ├── examples
    │   ├── default-blacklist-dirs-modules.nix
    │   └── default-change-dir-root.nix
    ├── lib.nix
    ├── README.md
    └── template
        └── default.nix

4 directories, 5 files
```

## Files

This library has to main files:
- `./lib.nix`: The module containing the recursive loading logic
- `./template/default.nix`: The module you need to add to your modules structure (learn more about this
below). This is the module users can copy and customize to fit their needs.

Additionally, there is also the `./examples` directory to help you get started quickly.

---

## Getting started

### 1. Add the library to your flake 

To use the `module-loader` library in your NixOS configuration, copy the `./template/default.nix` file to the root directory where you want `module-loader` begin to scan for Nix modules.

Alternatively, you can copy it anywhere else within your flake directory structure, and tell it where to look for modules. **This is not an encouraged practice.**
While it works and could be useful in some cases, it deviates from the way it is meant to be used following Nix/NixOS best practices. 

The last step is to import `default.nix`. This will vary from flake to flake dependind on how you
structure your modules--more about this in [ref]. 

### 2. Customize the template



///


### 2. Customize the Template

The `template/default.nix` file is provided as a starting point for using the `module-loader`. Copy this file to your project and adjust it as needed:

```bash
cp ./lib/module-loader/template/default.nix default.nix
```

#### Example `default.nix`
```nix
// filepath: default.nix
/*
  Template for using the module-loader.

  Copy this file to your project and adjust the `dir` and `excludePaths` as needed.
  This file is intentionally named default.nix to follow Nix conventions.
*/

{
  lib,
  ...
}:
let
  moduleLoader = import ./lib/module-loader/main.nix { inherit lib; };

  # Get the directory of this file
  dir = ./modules; # Replace with the path to your modules directory

  # Collect NixOS modules
  modules = moduleLoader.collectModules {
    inherit dir;

    # Files and directories to exclude
    excludePaths = [
      # Add paths to exclude here, if needed
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules;
}
```

---

## Notes

1. **`excludePaths` Validation**:
   - The `module-loader` enforces that `excludePaths` must be empty when passed to `collectModules`. If it is not empty, the module will throw an error with the offending value.

2. **Customizing Detection Patterns**:
   - The `module-loader` uses a default set of patterns to detect NixOS modules. These can be overridden by passing a custom `moduleDetection` list to `collectModules`.

3. **Template Location**:
   - The `template/default.nix` file is intentionally placed in the `template/` subdirectory to make it explicit that it is a customizable starting point. Users should copy and adjust this file as needed.

---

## Example Project Structure

Here’s an example of how your project might look after integrating the `module-loader`:

```
.
├── lib/
│   └── module-loader/
│       ├── main.nix
│       ├── README.md
│       └── template/
│           └── default.nix
├── modules/
│   ├── module1.nix
│   ├── module2.nix
│   └── subdir/
│       └── module3.nix
└── default.nix
```

- **`lib/module-loader/`**: Contains the `module-loader` library.
- **`modules/`**: Contains your NixOS modules to be dynamically loaded.
- **`default.nix`**: A copy of the `template/default.nix` file, customized for your project.

---

## Error Handling

The `module-loader` is designed to fail fast and provide clear error messages if misused. For example:
- If `excludePaths` is not empty, the following error will be thrown:
  ```
  Error: 'excludePaths' must be empty when passed to 'collectModules'.

  Found: [ "/some/path" ]

  Please ensure that 'excludePaths' is not set in this context.
  ```

---

## Contributing

If you have suggestions for improving the `module-loader` or its template, feel free to submit a pull request or open an issue.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
```

---

### Why This README Works
1. **Clear Structure**:
   - The directory structure and file purposes are explained upfront.
2. **Step-by-Step Instructions**:
   - Users are guided through importing the module and customizing the template.
3. **Error Handling**:
   - The README highlights potential errors and how to avoid them.
4. **Community Alignment**:
   - The use of default.nix as the template name and the inclusion of a `template/` subdirectory align with Nix/NixOS conventions.

This README ensures that both experienced and inexperienced users can easily understand and use the `module-loader` module.