

This project demonstrates assembly language programming using the **Irvine32 Library** for x86 architecture. The Irvine library provides useful macros, input/output functions, and more for assembly language programs.

## 📋 Requirements

- **Operating System**: `Windows` (for compatibility with the Irvine32 library)
- **Assembler**: `MASM` (Microsoft Macro Assembler)
- **IDE**: `Visual Studio` or any editor with MASM support (e.g., Visual Studio Code with the MASM extension)
- **Irvine32 Library**: The Irvine32 library files must be included in your project to use the provided macros.

## 🛠️ Setting Up the Irvine32 Library

1. **Download the Irvine32 Library**:
   -
2. **Include Irvine32 Library Files**:
   After downloading the library, include the following files in your project:
   - `Irvine32.inc` (includes macros for easy input/output handling)
   - `Irvine32.lib` (library file for linking with your project)

3. **Configure the Build Settings**:
   If using **Visual Studio**, set the following:
   - **Include directory**: Point to the folder where `Irvine32.inc` is located.
   - **Library directory**: Point to the folder containing `Irvine32.lib`.
   - **Linker input**: Ensure that `Irvine32.lib` is added as an additional dependency.

