# KeyCrafter
**Crafting secure keys tailored to your needs.****Forge unbreakable passwords with ease.**

PassForge is a command-line password generator tool designed to create secure, customizable passwords. Built with portability and ease-of-use in mind, it supports multiple options to fine-tune the output for different security needs. Whether you're generating simple lowercase passwords or strong, mixed-character vault keys, PassForge has you covered.

---

## 🚀 Features
- Fully customizable password length
- Support for uppercase, lowercase, or mixed case letters
- Option to include or exclude special characters
- Configurable count of special characters
- Dependency check to ensure cross-platform compatibility
- Randomized output using `/dev/urandom` and GNU utilities

---

## 🛠️ Dependencies
PassForge relies on a few common Unix utilities. Make sure these are installed on your system:

- `shuf` (or `gshuf` on macOS)
- `fold`
- `paste`
- `od`
- `tr`
- `cut`
- `sha256sum`
- `date`

The script will automatically check for missing dependencies and notify the user.

---

## 📦 Installation
```bash
# Clone the repository
$ git clone https://github.com/yourusername/passforge.git

# Change directory
$ cd passforge

# Make it executable
$ chmod +x passwdgen.sh

# Run it
$ ./passwdgen.sh [OPTIONS]
```

---

## 📋 Usage
```bash
Usage: passwdgen [OPTIONS]

Password Generator Tool
-----------------------
Generate a random password with configurable length, case options, and special characters.

Options:
  -h, /?           Display this help message and exit.
  -S               Disable special characters in the generated password.
                   (Default: special characters enabled.)
  -l LENGTH        Set the total password length (integer). Default: 8.
  -L LENGTH        Set the number of special characters to append.
                   Must be less than the total password length. Default: 2.
  -c CASE          Specify the case mode for the password:
                     u, upper  - all uppercase letters,
                     l, lower  - all lowercase letters,
                     b, both   - mixed case (default).
```

---

## 🧪 Examples
```bash
# Generate a 12-character password with 3 special characters in uppercase
$ ./passwdgen.sh -l 12 -L 3 -c upper

# Generate a 10-character password without special characters in lowercase
$ ./passwdgen.sh -S -l 10 -c lower
```

---

## 🤝 Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License
[MIT](LICENSE)

---

## ✨ Credits
Created with ❤️ by [Your Name] – [@yourhandle](https://github.com/yourusername)

