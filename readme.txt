Notes to Professor Holliday, 

I believe my assignment 3 is almost done.

However I am facing quite a few problems with calucalating the mean.

The area of interest is in the manager.asm file, lines 167-171.

Firstly my array size, cells is stored in a general purpose register. While my sum is in a xmm register. I have to find a way to get cells into an xmm register.
Secondly, the array size is a not a float, I need to make them the same type of number so that they can divide. Both need to be floats. 

xorpd xmm12, xmm12 ; I first cleared space in xmm12 as I plan to store the array size here
mov rax, cells ; Then I move # of elemnts into rax. I couldn't find any other way to move cells around. 
cvtsi2sd xmm12, rax ; I next converted xmm12 to a float so that it can divide the sum
divsd xmm13, xmm12 ; Lastly I divided 

I believe that should have worked but instead I got a very small number that was not the mean.