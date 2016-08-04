;;; nand2tetris-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "nand2tetris" "nand2tetris.el" (22321 16663
;;;;;;  0 0))
;;; Generated autoloads from nand2tetris.el

(autoload 'nand2tetris//snippets-initialize "nand2tetris" "\
Initialize snippets directory.

\(fn)" nil nil)

(eval-after-load 'yasnippet #'(nand2tetris//snippets-initialize))

(autoload 'nand2tetris-mode "nand2tetris" "\
Major mode for editing HDL files for the course Nand2Tetris.

\\{nand2tetris-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist (progn `(,(concat (expand-file-name nand2tetris-core-base-dir) ".*\\.hdl") \, #'nand2tetris-mode)))

;;;***

;;;### (autoloads nil "nand2tetris-core" "nand2tetris-core.el" (22321
;;;;;;  16663 0 0))
;;; Generated autoloads from nand2tetris-core.el

(define-namespace nand2tetris-core (defcustom -base-dir "~/Downloads/nand2tetris" "Source directory where nadn2tetris has been downloaded." :group 'nand2tetris) (defconst -builtin-chips '(("Add16" ("description" . "16-bit bitwise And:\n\nIN a[16], b[16];\nOUT out[16];\n\nfor i = 0..15: out[i] = (a[i] and b[i])") ("spec" . "Add16(a= ,b= ,out= )")) ("ALU" ("description" . " The ALU (Arithmetic Logic Unit).\n\nIN\n    x[16], y[16],  // 16-bit inputs\n    zx, // zero the x input?\n    nx, // negate the x input?\n    zy, // zero the y input?\n    ny, // negate the y input?\n    f,  // compute out = x + y (if 1) or x & y (if 0)\n    no; // negate the out output?\n\nOUT\n    out[16], // 16-bit output\n    zr, // 1 if (out == 0), 0 otherwise\n    ng; // 1 if (out < 0),  0 otherwise\n\nComputes one of the following functions:\nx+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,\nx+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs,\naccording to 6 input bits denoted zx,nx,zy,ny,f,no.\nIn addition, the ALU computes two 1-bit outputs:\nif the ALU output == 0, zr is set to 1; otherwise zr is set to 0;\nif the ALU output < 0, ng is set to 1; otherwise ng is set to 0.\n\nImplementation: the ALU logic manipulates the x and y inputs\nand operates on the resulting values, as follows:\nif (zx == 1) set x = 0        // 16-bit constant\nif (nx == 1) set x = !x       // bitwise not\nif (zy == 1) set y = 0        // 16-bit constant\nif (ny == 1) set y = !y       // bitwise not\nif (f == 1)  set out = x + y  // integer 2's complement addition\nif (f == 0)  set out = x & y  // bitwise and\nif (no == 1) set out = !out   // bitwise not\nif (out == 0) set zr = 1\nif (out < 0) set ng = 1\n") ("spec" . "ALU(x= ,y= ,zx= ,nx= ,zy= ,ny= ,f= ,no= ,out= ,zr= ,ng= )")) ("And16" ("description" . "16-bit bitwise And:\n\nIN a[16], b[16];\nOUT out[16];\n\nfor i = 0..15: out[i] = (a[i] and b[i])") ("spec" . "And16(a= ,b= ,out= )")) ("And" ("description" . "And gate:\n\nIN a, b;\nOUT out;\n\nout = 1 if (a == 1 and b == 1)\n      0 otherwise") ("spec" . "And(a= ,b= ,out= )")) ("ARegister" ("description" . "A 16-Bit register called \"A Register\".\n\nIN  in[16], load;\nOUT out[16];\n\nBUILTIN ARegister;\nCLOCKED in, load;\n\nIf load[t-1]=1 then out[t] = in[t-1]\nelse out does not change (out[t] = out[t-1])\n\nThis built-in chip implementation has the side effect of\nproviding a GUI representation of a 16-bit register\ncalled \"A register\" (typically used to store an address)") ("spec" . "ARegister(in= ,load= ,out= )")) ("Bit" ("description" . "1-bit register:\n\nIN in, load;\nOUT out;\n\nIf load[t] == 1 then out[t+1] = in[t]\n                else out does not change (out[t+1] = out[t])") ("spec" . "Bit(in= ,load= ,out= )")) ("CPU" ("description" . " The Hack CPU (Central Processing unit)\n\nIN  inM[16],         // M value input  (M = contents of RAM[A])\n    instruction[16], // Instruction for execution\n    reset;           // Signals whether to re-start the current\n                        // program (reset==1) or continue executing\n                        // the current program (reset==0).\n\nOUT outM[16],        // M value output\n    writeM,          // Write to M?\n    addressM[15],    // Address in data memory (of M)\n    pc[15];          // address of next instruction\n\nConsisting of an ALU,two registers named A and D, and a program\ncounter named PC. The CPU is designed to fetch and execute\ninstructions written in the Hack machine language. In particular,\nfunctions as follows: Executes the inputted instruction according\nto the Hack machine language specification. The D and A in the\nlanguage specification refer to CPU-resident registers, while M\nrefers to the external memory location addressed by A, i.e. to\nMemory[A]. The inM input holds the value of this location. If the\ncurrent instruction needs to write a value to M, the value is\nplaced in outM, the address of the target location is placed in\nthe addressM output, and the writeM control bit is\nasserted. (When writeM==0, any value may appear in outM). The\noutM and writeM outputs are combinational: they are affected\ninstantaneously by the execution of the current instruction. The\naddressM and pc outputs are clocked: although they are affected\nby the execution of the current instruction, they commit to their\nnew values only in the next time step. If reset==1 then the CPU\njumps to address 0 (i.e. pc is set to 0 in next time step) rather\nthan to the address resulting from executing the current\ninstruction.") ("spec" . "CPU(inM= ,instruction= ,reset= ,outM= ,writeM= ,addressM= ,pc= )")) ("DFF" ("description" . "Data Flip-flop:\n\nIN  in;\nOUT out;\n\nout(t) = in(t-1) \nwhere t is the current time unit, or clock cycle.") ("spec" . "DFF(in= ,out= )")) ("DMux4Way" ("description" . "4-way demultiplexor:\n\nIN in, sel[2];\nOUT a, b, c, d;\n\n{a, b, c, d} = {in, 0, 0, 0} if sel == 00\n               {0, in, 0, 0} if sel == 01\n               {0, 0, in, 0} if sel == 10\n               {0, 0, 0, in} if sel == 11") ("spec" . "DMux4Way(in= ,sel= ,a= ,b= ,c= ,d= )")) ("DMux8Way" ("description" . "8-way demultiplexor:\n\nIN in, sel[3];\nOUT a, b, c, d, e, f, g, h;\n\n{a, b, c, d, e, f, g, h} = {in, 0, 0, 0, 0, 0, 0, 0} if sel == 000\n                           {0, in, 0, 0, 0, 0, 0, 0} if sel == 001\n                           etc.\n                           {0, 0, 0, 0, 0, 0, 0, in} if sel == 111") ("spec" . "DMux8Way(in= ,sel= ,a= ,b= ,c= ,d= ,e= ,f= ,g= ,h= )")) ("DMux" ("description" . "Demultiplexor:\n\nIN in, sel;\nOUT a, b;\n\n{a, b} = {in, 0} if sel == 0\n         {0, in} if sel == 1") ("spec" . "DMux(in= ,sel= ,a= ,b= )")) ("DRegister" ("description" . " A 16-Bit register called \"D Register\"\n\nIN  in[16], load;\nOUT out[16];\n\nIf load[t-1]=1 then out[t] = in[t-1]\nelse out does not change (out[t] = out[t-1])\n\nThis built-in chip implementation has the side effect of\nproviding a GUI representation of a 16-bit register\ncalled \"D register\" (typically used to store data).") ("spec" . "DRegister(in= ,load= ,out= )")) ("FullAdder" ("description" "FullAdder Chip:\n\nIN a, b, c;  // 1-bit inputs\nOUT sum,     // Right bit of a + b + c\n    carry;   // Left bit of a + b + c\n\nComputes the sum of three bits.") ("spec" . "FullAdder(a= ,b= ,c= ,sum= ,carry= )")) ("HalfAdder" ("description" . "HafAdder Chip:\nIN a, b;    // 1-bit inputs\nOUT sum,    // Right bit of a + b \n    carry;  // Left bit of a + b\n\nComputes the sum of two bits.") ("spec" . "HalfAdder(a= ,b= ,sum= , carry= )")) ("Inc16" ("description" . "Inc16 Chip:\n\nIN in[16];\nOUT out[16];\n\n\n16-bit incrementer:\nout = in + 1 (arithmetic addition)") ("spec" . "Inc16(in= ,out= )")) ("Keyboard" ("description" . "The keyboard (memory map).\n\nOUT out[16];   // The ASCII code of the pressed key,\n               // or 0 if no key is currently pressed,\n               // or one the special codes listed in Figure 5.5.\n\nOutputs the code of the currently pressed key.\n\nThe built-in chip implementation has two side effects supplied\nby the simulator. First, the keyboard memory map is continuously\nbeing refreshed from the physical keyboard unit. Second, it\ndisplays a keyboard icon and data entry GUI.") ("spec" . "Keyboard(out= )")) ("Memory" ("description" . "The Memory:\n\nIN in[16], load, address[15];\nOUT out[16];\n\nThe complete address space of the Hack computer's memory,\nincluding RAM and memory-mapped I/O.\nThe chip facilitates read and write operations, as follows:\n    Read:  out(t) = Memory[address(t)](t)\n    Write: if load(t-1) then Memory[address(t-1)](t) = in(t-1)\nIn words: the chip always outputs the value stored at the memory\nlocation specified by address. If load==1, the in value is loaded\ninto the memory location specified by address. This value becomes\navailable through the out output from the next time step onward.\nAddress space rules:\nOnly the upper 16K+8K+1 words of the Memory chip are used.\nAccess to address>0x6000 is invalid. Access to any address in\nthe range 0x4000-0x5FFF results in accessing the screen memory\nmap. Access to address 0x6000 results in accessing the keyboard\nmemory map. The behavior in these addresses is described in the\nScreen and Keyboard chip specifications given in the book.") ("spec" . "Memory(in= ,load= ,address= ,out= )")) ("Mux16" ("description" . "16-bit multiplexor:\n\nIN a[16], b[16], sel;\nOUT out[16];\n\nfor i = 0..15 out[i] = a[i] if sel == 0\n                       b[i] if sel == 1") ("spec" . "Mux16(a= ,b= ,sel= ,out= )")) ("Mux4Way16" ("description" . "4-way 16-bit multiplexor:\n\nIN a[16], b[16], c[16], d[16], sel[2];\nOUT out[16];\n\nout = a if sel == 00\n      b if sel == 01\n      c if sel == 10\n      d if sel == 11") ("spec" . "Mux4Way16(a= ,b= ,c= ,d= ,sel= ,out= )")) ("Mux8Way16" ("description" . "8-way 16-bit multiplexor:\n\nIN a[16], b[16], c[16], d[16],\n    e[16], f[16], g[16], h[16],\n    sel[3];\nOUT out[16];\n\nout = a if sel == 000\n      b if sel == 001\n      etc.\n      h if sel == 111") ("spec" . "Mux8Way16(a= ,b= ,c= ,d= ,e= ,f= ,g= ,h= ,sel= ,out= )")) ("Mux" ("description" . "Multiplexor:\n\nIN a, b, sel;\nOUT out;\n\nout = a if sel == 0\n      b otherwise") ("spec" . "Mux(a= ,b= ,sel= ,out= )")) ("Nand" ("description" . "Nand gate:\n\nIN  a, b;\nOUT out;\n\nout = a Nand b.") ("spec" . "Nand(a= ,b= ,out= )")) ("Not16" ("description" . "16-bit Not:\n\nIN in[16];\nOUT out[16];\n\nfor i=0..15: out[i] = not in[i]") ("spec" . "Not16(in= ,out= )")) ("Not" ("description" . "Not gate:\n\nIN in;\nOUT out;\n\nout = not in") ("spec" . "Not(in= ,out= )")) ("Or16" ("description" . "16-bit bitwise Or:\n\nIN a[16], b[16];\nOUT out[16];\n\nfor i = 0..15 out[i] = (a[i] or b[i])") ("spec" . "Or16(a= ,b= ,out= )")) ("Or8Way" ("description" . "8-way Or: \n\nIN in[8];\nOUT out;\n\nout = (in[0] or in[1] or ... or in[7])") ("spec" . "Or8Way(in= ,out= )")) ("Or" ("description" . "Or gate:\n\nIN  a, b;\nOUT out;\n\nout = 1 if (a == 1 or b == 1)\n        0 otherwise") ("spec" . "Or(a= ,b= ,out= )")) ("PC" ("description" . "PC Chip:\n\nIN in[16],load,inc,reset;\nOUT out[16];\n\nA 16-bit counter with load and reset control bits.\nif      (reset[t] == 1) out[t+1] = 0\nelse if (load[t] == 1)  out[t+1] = in[t]\nelse if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition)\nelse                    out[t+1] = out[t]") ("spec" . "PC(in= ,load= ,inc= ,reset= ,out= )")) ("RAM16K" ("description" . "RAM16K Chip\n\nIN in[16], load, address[14];\nOUT out[16];\n\nMemory of 16K registers, each 16 bit-wide. Out holds the value\nstored at the memory location specified by address. If load==1,\nthen the in value is loaded into the memory location specified by\naddress (the loaded value will be emitted to out from the next\ntime step onward).") ("spec" . "RAM16K(in= ,load= ,address= ,out= )")) ("RAM4K" ("description" . "RAM4K Chip:\n\nIN in[16], load, address[12];\nOUT out[16];\n\nMemory of 4K registers, each 16 bit-wide. Out holds the value\nstored at the memory location specified by address. If load==1, then\nthe in value is loaded into the memory location specified by address\n(the loaded value will be emitted to out from the next time step onward).") ("spec" . "RAM4K(in= ,load= ,address= ,out= )")) ("RAM512" ("description" . "RAM512 Chip\n\nIN in[16], load, address[9];\nOUT out[16];\n\nMemory of 512 registers, each 16 bit-wide. Out holds the value\nstored at the memory location specified by address. If load==1, then\nthe in value is loaded into the memory location specified by address\n(the loaded value will be emitted to out from the next time step onward).") ("spec" . "RAM512(in= ,load= ,address= ,out= )")) ("RAM64" ("description" . "RAM64 Chip:\n\nIN in[16], load, address[6];\nOUT out[16];\n\nMemory of 64 registers, each 16 bit-wide. Out holds the value\nstored at the memory location specified by address. If load==1, then\nthe in value is loaded into the memory location specified by address\n(the loaded value will be emitted to out from the next time step onward).") ("spec" . "RAM64(in= ,load= ,address= ,out= )")) ("RAM8" ("description" . "RAM8 Chip:\n\nIN in[16], load, address[3];\nOUT out[16];\n\nMemory of 8 registers, each 16 bit-wide. Out holds the value\nstored at the memory location specified by address. If load==1, then\nthe in value is loaded into the memory location specified by address\n(the loaded value will be emitted to out from the next time step onward).") ("spec" . "RAM8(in= ,load= ,address= ,out= )")) ("Register" ("description" . "16-bit register:\nIN in[16], load;\nOUT out[16];\n\nIf load[t] == 1 then out[t+1] = in[t]\nelse out does not change") ("spec" . "Register(in= ,load= ,out= )")) ("ROM32K" ("description" . "ROM32K Chip:\n\nIN  address[15];\nOUT out[16];\n\nRead-Only memory (ROM) of 16K registers, each 16-bit wide.\nThe chip is designed to facilitate data read, as follows:\n    out(t) = ROM32K[address(t)](t)\nIn words: the chip always outputs the value stored at the\nmemory location specified by address.\n\nThe built-in chip implementation has a GUI side-effect,\nshowing an array-like component that displays the ROM's\ncontents. The ROM32K chip is supposed to be pre-loaded with\na machine language program. To that end, the built-in chip\nimplementation also knows how to handle the \"ROM32K load Xxx\"\nscript command, where Xxx is the name of a text file containing\na program written in the Hack machine language.  When the\nsimulator encounters such a command in a test script, the code\nfound in the file is loaded into the simulated ROM32K unit.") ("spec" . "ROM32K(address= ,out= )")) ("Screen" ("description" . "The Screen (memory map).\n\nIN  in[16],        // what to write\n    load,          // write-enable bit\n    address[13];   // where to read/write\nOUT out[16];       // Screen value at the given address\n\nFunctions exactly like a 16-bit 8K RAM:\n   1. out(t)=Screen[address(t)](t)\n   2. If load(t-1) then Screen[address(t-1)](t)=in(t-1)\n\nThe built-in chip implementation has the side effect of continuously\nrefreshing a visual 256 by 512 black-and-white screen, simulated\nby the simulator. Each row in the visual screen is represented\nby 32 consecutive 16-bit words, starting at the top left corner\nof the visual screen. Thus the pixel at row r from the top and\ncolumn c from the left (0<=r<=255, 0<=c<=511) reflects the c%16\nbit (counting from LSB to MSB) of the word found in\nScreen[r*32+c/16].") ("spec" . "Screen(in= ,load= ,address= ,out= )")) ("Xor" ("description" . "Exclusive-or gate:\n\nIN a, b;\nOUT out;\n\nout = !(a == b).") ("spec" . "Xor(a= ,b= ,out= )"))) "Built In Chips Alist."))

;;;***

;;;### (autoloads nil nil ("nand2tetris-pkg.el") (22321 16663 227246
;;;;;;  0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; nand2tetris-autoloads.el ends here
