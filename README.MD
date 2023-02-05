IT Practical Assessment Task - 2021 _Grade 10_
=================================================  
  
This PAT focuses on code generation, and was graded 83/83 (100%). The PAT, coded in Delphi (Pascal) is complete with comments, quality code, a help-website, and more.  
  
![License](https://img.shields.io/github/license/SkillBeatsAll/itpat-2021?color=6995db&style=for-the-badge) ![visitors](https://shields-io-visitor-counter.herokuapp.com/badge?page=SkillBeatsAll.itpat-2021&color=6995db&style=for-the-badge)  
  
  
Table of contents  
-----------------  
  
* [Introduction](#introduction)  
* [Scope](#scope)  
* [Usage](#usage)   
* [Getting help](#getting-help)  
* [License](#license)  
  
  
Introduction  
------------  
  
This repository contains all the required files to compile the PAT. The PAT is based on the provided [scope](#scope), and is complete with comments, functions, text-file implementation, a help website, appropriate hints, and more.  
  
The project contains 4 forms:  
1. Login / Register Form: Complete with a CAPTCHA, text file for credentials storing, and a beautiful GUI.  
2. Verification Form: This form completes the MFA requirement of the PAT, by asking the user for their provided PIN code, which they received upon registration.  
3. Main Program (Password / Serial Key generation): Meets the code-generation requirement of the PAT. It can generate passwords, or serial keys with optional delimiters.  
4. Help Website: A form dedicated to displaying the help-website, which is coded in HTML, and available in the project files.  
  
  
Scope  
------------  
(*taken from DBE - INFORMATION TECHNOLOGY GUIDELINES FOR PRACTICAL ASSESSMENT TASK*)  
  
Today, cybersecurity requires the generation of codes. Also, to install software requires serial keys/ installation codes/product keys.  
In terms of cybersecurity, the codes could include passwords (associated with usernames) as well as codes generated for multi-factor authentication that requires you to provide more than one form of identification at the time of login to ensure you are who you claim to be.  
  
Multi-factor authentication generally considers:  
• Something the user knows (i.e. a password, PIN or pattern)  
• Something the user has (i.e. a physical OTP (one-time-password) token or security USB key  
• Something that is inherent to the user (typically a biometric signature)  
Note: in some cases, location and network indicators are also used as additional authentication factors.  
  
Codes could also include CAPTCHA codes such as standard CAPTCHA, picture authentication, math solution, 3-D CAPTCH, drag-and-drop CAPTCHA, Tic Tac Toe CAPTCHA, etc.  
  
You need to develop a program that generates codes. These codes could include one or more of the following:  
• Passwords  
• Passcodes, e.g. a pin or one-time passwords  
• Challenge/Response – answers to challenge questions that may include obscure personal information  
• Multiple codes written in a grid and user must enter code from specific row and column  
• Product codes/keys  
  
Your program must also use multi-level authentication, e.g. to be able to use it, the user must enter a username with password PLUS using at least ONE other authentication method to ensure that the user is human such as using a CAPTCHA code.  
  
Aspects of your program may include the user specifying:  
• Length of the code/key  
• Format of the code/key  
• Which combination of characters it should include, e.g. only letters and numbers or letters, numbers, special characters, binary replacements for a number, etc.  
• Check digit, e.g. calculated using mod 9 of the sum of numeric values or request a check digit calculated in one of a couple of listed ways (select the one s/he wants)  
  
Usage  
-----  
This project can be compiled and ran through the Delphi IDE (RAD Studio). The executable file will be saved in the main directory of the project, which can then be distributed.  
  
Getting help  
------------  
  
You can contact me via [email](mailto:joelcedras@gmail.com), via [Twitter](https://twitter.com/n0tjoel), or via [Discord](https://discordhub.com/profile/234576713005137920).
  
  
License  
-------  
  
This project is distributed under the terms of the [MIT license](https://github.com/SkillBeatsAll/itpat-2021/blob/ecbcb7c27645d228d002749588ef2001bba0564a/LICENSE). The license applies to this file and other files in the [GitHub repository](http://github.com/SkillBeatsAll/itpat-2021) hosting this file.

```
Copyright (C) 2021 Joel Cedras / SkillBeatsAll.

Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://opensource.org/licenses/MIT

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.
```

