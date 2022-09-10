.model small
.stack 100h 
.data 
stringg db "Candy Crush$"
stringnextbutton db "Next$"
failstring db "Level Failed!"
stringtryagainbutton db "Try Again$"
overstring db "Game Over$"
stringplayagainbutton db "Play Again$"
stringlevel1 db "Level: 1$"
stringlevel2 db "Level: 2$"
stringscore db "Score: $"
stringsc0 db "0$"
stringsc10 db "10$"
stringsc20 db "20$"
stringsc30 db "30$"
stringsc40 db "40$"
stringsc50 db "50$"
stringsc60 db "50$"
stringrules db "-> Candy Crush is a match-three game, where the core game play is based on swapping two adjacent random candies among several on the game board to make a row / column of at least three matching-random candies. $"
stringrules1 db "-> On this match, the matched random candies are removed from the board, and randomcandies above them fall into the empty spaces, with new random candies appearing from the top of the board.$"
stringrules2 db "-> This may create a new matched set of random candies, which is automatically     cleared in the same manner.$"
stringrules3 db "-> The game is split among many levels,which must be completed in sequence.$"
stringgap db "                                                                                                              $"
stringgap1 db "                                                                                                                                  $"
stringgap2 db "                                                                                                                                  $"
grid db 1,1,2,2,1,5,4
     db 2,6,5,4,6,3,1
     db 1,1,6,4,5,1,6
     db 5,4,4,2,1,5,6
     db 6,3,6,1,3,6,3
     db 2,1,3,4,5,1,6
     db 5,2,2,1,5,3,4 

gridlvl2 db 0,1,2,0,1,5,0
         db 0,6,5,4,6,3,0
         db 1,1,6,4,5,1,6
         db 0,4,4,2,1,5,0
         db 6,3,6,1,3,6,3
         db 0,1,3,4,5,1,0
         db 0,2,2,0,5,3,0    
x db 0
y db 0
prevscore dw 0
misscounter db 0
xcor dw 0
ycor dw 0
xcorf dw 0
ycorf dw 0
xdiff dw 0
ydiff dw 0
key db 0
xlow dw 0
xhigh dw 0
ylow dw 0
score dw 0
yhigh dw 0
counter db 0
i db 0
j db 0
k dw 0
xc dw 0
yc dw 0
cnt dw 0
temp dw 0
colorofgrid db 0
color db 0
reset dw 0
index1 dw 0
index2 dw 0
innercounter dw 0
move dw 0
tmmp db 0
.code 

Delay proc 
    push cx
    push dx
    mov cx,1000
    l1:
        mov dx,1000
        l2:
            dec dx
            cmp dx,0
            jne l2 
            loop l1
            pop dx 
            pop cx 
            ret 
Delay endp

printgrid proc 



mov ah,0;video mode
mov al,12h;display line, 620x480
int 10h;interrupt

int 10h 
mov ah,02h
mov bx,0
mov dh,4
mov dl,2
int 10h

mov dx, offset stringlevel1
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,5
mov dl,2
int 10h

mov dx, offset stringscore
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,5
mov dl,8
int 10h

.if(score==0)
    
mov dx, offset stringsc0
mov ah,09h 
int 21h
.endif
.if(score==10)
 mov dx, offset stringsc10
mov ah,09h 
int 21h
.endif
.if(score==20)
 mov dx, offset stringsc20
mov ah,09h 
int 21h
.endif
.if(score==30)
 mov dx, offset stringsc30
mov ah,09h 
int 21h
.endif
    mov cx,120;x
    .while cx<521
        mov dx,40;y
        mov bx,0
        .while dx<440
        mov ah,0ch
        mov al,colorofgrid
        int 10h
        inc dx
        .endw
    add cx,57
    .endw
    ;dx
    mov dx,40
    .while dx<441
        mov cx,120
        .while cx<520
        mov ah,0ch
        mov al,colorofgrid
        int 10h
        inc cx
        .endw
    add dx,57
    .endw


ret
printgrid endp

printgridlvl2 proc 
mov ah,0;video mode
mov al,12h;display line, 620x480
int 10h;interrupt

int 10h 
mov ah,02h
mov bx,0
mov dh,4
mov dl,2
int 10h

mov dx, offset stringlevel2
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,5
mov dl,2
int 10h

mov dx, offset stringscore
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,5
mov dl,8
int 10h

.if(score==0)
    
mov dx, offset stringsc0
mov ah,09h 
int 21h
.endif
.if(score==10)
 mov dx, offset stringsc10
mov ah,09h 
int 21h
.endif
.if(score==20)
 mov dx, offset stringsc20
mov ah,09h 
int 21h
.endif
.if(score==30)
 mov dx, offset stringsc30
mov ah,09h 
int 21h
.endif
.if(score==40)
 mov dx, offset stringsc30
mov ah,09h 
int 21h
.endif
mov temp,0
    mov cx,120;x
    .while cx<521
        .if(temp==0)
            mov dx,154;y
            mov bx,0
            .while dx<326
            mov ah,0ch
            mov al,colorofgrid
            int 10h
            inc dx
            .endw
        .endif
        .if(temp==7)
            mov dx,154;y
            mov bx,0
            .while dx<326
            mov ah,0ch
            mov al,colorofgrid
            int 10h
            inc dx
            .endw
        .endif
        .if(temp>0)
            .if(temp<7)
                mov dx,40;y
                mov bx,0
                .while dx<440
                mov ah,0ch
                mov al,colorofgrid
                int 10h
                inc dx
                .endw
            .endif
        .endif
    inc temp
    add cx,57
    .endw
    ;dx
    mov temp,0
    mov dx,40
    .while dx<441
        .if(temp<2)
            mov cx,177
            .while cx<463
            mov ah,0ch
            mov al,colorofgrid
            int 10h
            inc cx
            .endw
        .endif
        .if(temp>5)
            mov cx,177
            .while cx<463
            mov ah,0ch
            mov al,colorofgrid
            int 10h
            inc cx
            .endw
        .endif
        .if(temp>1)
            .if(temp<6)
                mov cx,120
                .while cx<520
                mov ah,0ch
                mov al,colorofgrid
                int 10h
                inc cx
                .endw
            .endif
        .endif
        inc temp
    add dx,57
    .endw

    mov cx,291
    mov dx,40
    .while cx<348
        mov ah,0ch
        mov al,0;color black
        int 10h
        inc cx
    .endw
    mov cx,291
    mov dx,439
    .while cx<348
        mov ah,0ch
        mov al,0;color black
        int 10h
        inc cx
    .endw
    mov cx,120
    mov dx,211
    .while dx<268
        mov ah,0ch
        mov al,0;color black
        int 10h
        inc dx
    .endw
    mov cx,519
    mov dx,211
    .while dx<268
        mov ah,0ch
        mov al,0;color black
        int 10h
        inc dx
    .endw
jret:
ret
printgridlvl2 endp

fail proc 

mov ah,0;video mode
mov al,12h;display line, 620x480
int 10h;interrupt

int 10h 
mov ah,02h
mov bx,0
mov dh,12
mov dl,34
int 10h

mov dx, offset failstring
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,25
mov dl,60
int 10h

mov dx, offset stringtryagainbutton
mov ah,09h 
int 21h

mov x,0

.while x==0
    mov ax,1
    int 33h
    mov ax,5
    int 33h 
    .if ax==1
        int 33h 
        mov ax,3
        .if cx>479
            .if cx<511
                .if dx>399
                    .if dx<409 
                        jmp main
                    .endif
                .endif
            .endif
        .endif
    .endif
.endw

fail endp


gameend proc 

mov ah,0;video mode
mov al,12h;display line, 620x480
int 10h;interrupt

int 10h 
mov ah,02h
mov bx,0
mov dh,12
mov dl,34
int 10h

mov dx, offset overstring
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,25
mov dl,60
int 10h

mov dx, offset stringplayagainbutton
mov ah,09h 
int 21h

mov x,0

.while x==0
    mov ax,1
    int 33h
    mov ax,5
    int 33h 
    .if ax==1
        int 33h 
        mov ax,3
        .if cx>479
            .if cx<511
                .if dx>399
                    .if dx<409 
                        jmp main
                    .endif
                .endif
            .endif
        .endif
    .endif
.endw

gameend endp
printsquare proc 

mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov x,0
mov i,0
mov k,0
mov j,0
mov xc,0
mov yc,0
mov temp,0
mov cnt,0

mov x,70
.if(key==1)
mov si,offset grid
.endif
.if(key==2)
mov si,offset gridlvl2
.endif
.while x>1
    ;increment in x
    mov al, 57 
    mov bl,i
    mul bl 
    mov xc,ax
    ;mov i,bl 
    ;increment in y
    mov al, 57 
    mov bl,j
    mul bl 
    mov yc,ax
    ;mov j,bl
    ;
    mov cx,135;x
    add cx,xc
    mov dx,53;y
    add dx,yc 
    mov bx,0
    mov k,83
    mov ax,yc 
    add k,ax
    mov temp,dx
    mov cnt,cx 
    add cnt,30 
    mov ax,[si]
    ;add ax,48
    mov color,al
   ; mov ah,02h
   ; int 21h
    inc si 
    .while cx<cnt
        .while dx<k
            mov ah,0ch
            mov al,color
            int 10h
            inc dx
        .endw
        mov dx,temp
        inc cx
    .endw
    inc i 
    .if i==7
        mov i,0 
        inc j
    .endif
    ;inc x
    .if j==7
        ret 
    .endif
.endw
printsquare endp

output proc
;mov ax,ycor
mov bl,10
l1:
cmp al,0
je display
div bl
mov cl,ah
mov ch,0
push cx
mov ah,0
inc counter
jmp l1
display:
cmp counter,0
je retlabel
pop dx
add dx,48
mov ah,02h
int 21h
dec counter
jmp display
retlabel:
mov counter,0
ret
output endp

output1 proc
mov ax,ycorf
mov bl,10
l11:
cmp al,0
je display1
div bl
mov cl,ah
mov ch,0
push cx
mov ah,0
inc counter
jmp l11
display1:
cmp counter,0
je retlabel1
pop dx
add dx,48
mov ah,02h
int 21h
dec counter
jmp display1
retlabel1:
mov counter,0
ret
output1 endp


main proc 
mov ax,@data
mov ds,ax
mov ah,0
mov al,12h

mov misscounter,0
mov score,0
int 10h 
mov ah,02h
mov bx,0
mov dh,12
mov dl,34
int 10h

mov dx, offset stringg
mov ah,09h 
int 21h

int 10h 
mov ah,02h
mov bx,0
mov dh,25
mov dl,60
int 10h

mov dx, offset stringnextbutton
mov ah,09h 
int 21h

mov x,0

.while x==0
    mov ax,1
    int 33h
    mov ax,5
    int 33h 
    .if ax==1
        int 33h 
        mov ax,3
        .if cx>479
            .if cx<511
                .if dx>399
                    .if dx<409 
                        jmp rulesdisp
                    .endif
                .endif
            .endif
        .endif
    .endif
.endw
rulesdisp:
mov ah,0
mov al,12h

int 10h 
mov ah,02h
mov bx,0
mov dh,10
mov dl,0
int 10h

mov dx, offset stringrules
mov ah,09h 
int 21h

mov dx,offset stringgap
mov ah,09h 
int 21h

mov dx, offset stringrules1
mov ah,09h 
int 21h

mov dx,offset stringgap1
mov ah,09h 
int 21h

mov dx, offset stringrules2
mov ah,09h 
int 21h

mov dx,offset stringgap2
mov ah,09h 
int 21h

mov dx, offset stringrules3
mov ah,09h 
int 21h

mov x,5
.while x>1
    call Delay
    dec x
.endw
;;grid drawing
mov colorofgrid,0fh
call printgrid
;;grid filling

mov color,2h
mov key,1
call printsquare

mov ax,0 ;reseting mouse
int 33h
mov ax,1;showing mouse
int 33h
mov i, 1
.while(score<30) 
    mov ax,0 ;reseting mouse
    int 33h
    mov ax,1;showing mouse
    int 33h
    mov i, 1
    .while i>0;while 1>0
        mov ax,5 ;click interrupt
        int 33h 
       .if ax==1
            mov ax,3
            mov xcor,cx ; storing x
            mov ycor,dx ; storing y
            int 33h
            jmp startx
       .endif 
    .endw
    startx:
    call delay
    .while i>0;while 1>0
        mov ax,5 ;click interrupt
        int 33h 
       .if ax==1
            mov ax,3
            mov xcorf,cx ; storing x
            mov ycorf,dx ; storing y
            int 33h
            jmp printcoorx
       .endif 
    .endw
    printcoorx:
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,xcor
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,ycor
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,xcorf
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,ycorf
        call output
        jmp movementx
    movementx:
;;;;code for finding index of first click
    mov temp,0
    mov reset,0
    mov index1,0
    mov xlow,134
    mov xhigh,164
    mov ylow,54
    mov yhigh,84

    mov ax,xcor
    mov bx,ycor
    .while(temp==0)
        .if (reset==7)
        add ylow,57
        add yhigh,57
        mov xlow,134
        mov xhigh,164
        mov reset,0
        .endif
        .if(ax>xlow)
            .if(ax<xhigh)
                .if(bx>ylow)
                    .if(bx<yhigh)
                        inc temp
                    .endif
                .endif 
            .endif
        .endif 

    add xlow,57
    add xhigh,57
    inc index1
    inc reset
    .endw

    mov dx,32
    mov ah,02h 
    int 21h

    mov ax,index1
    call output
    ;;;;;;;;;;;
    ;code for finding index of second click
    mov temp,0
    mov reset,0
    mov index2,0
    mov xlow,134
    mov xhigh,164
    mov ylow,54
    mov yhigh,84

    mov ax,xcorf
    mov bx,ycorf
    .while(temp==0)
        .if (reset==7)
        add ylow,57
        add yhigh,57
        mov xlow,134
        mov xhigh,164
        mov reset,0
        .endif
        .if(ax>xlow)
            .if(ax<xhigh)
                .if(bx>ylow)
                    .if(bx<yhigh)
                        inc temp
                    .endif
                    .endif 
                .endif
            .endif 

        add xlow,57
        add xhigh,57
        inc index2
        inc reset
        .endw

        mov dx,32
        mov ah,02h 
        int 21h

        mov ax,index2
        call output
        ;;;;;;;;;;;;;;;
        ;;;;;;deciding wether to move left right up down
        mov dx,32
        mov ah,02h 
        int 21h

        mov ax,index1
        add ax,1
        mov move,0
        .if(index2==ax)
        ;;right = 1
        mov move,1
        .endif

        mov ax,index2
        add ax,1
        .if(index1==ax)
        ;;left = 2
        mov move,2
        .endif

        mov ax,index2
        add ax,7
        .if(index1==ax)
        ;;up = 3
        mov move,3
        .endif 

        mov ax,index1
        add ax,7
        .if(index2==ax)
        ;;down = 4
        mov move,4
        .endif 
        ;;if none condition met here then just minus the score
        
            mov dx,32
            mov ah,02h
            int 21h
            mov dx,score 
            mov prevscore,dx 
            mov tmmp,0
            mov temp,0
            .if(move!=0)
                mov si,offset grid
                add si,index1
                sub si,1
                mov dl,[si]
                mov tmmp,dl

                mov si,offset grid
                add si,index2
                sub si,1
                mov dl,[si]

                mov si,offset grid
                add si,index1
                sub si,1
                mov [si],dl

                mov si,offset grid
                add si,index2
                sub si,1
                mov dl,tmmp
                mov [si],dl
            .endif
            mov i,0
            mov si,offset grid

            mov color,2h
            call printgrid
            call printsquare

            mov si,offset grid 
            mov i,0
            mov counter,0

            .while(i<49)
                mov dl,[si+1]
                mov bl,[si+2]
                .if([si]==dl)
                    .if(dl==bl)
                        add score,10
                        mov al,4
                        mov [si],al
                        mov al,6
                        mov [si+1],al
                        mov al,3
                        mov [si+2],al
                    .endif
                .endif
                .if(counter==5)
                    add si,2
                    add i,2
                    mov counter,0
                .endif
            inc i 
            inc counter
            inc si
            .endw

            mov counter,0
            mov si,offset grid 
            mov i,0
            mov counter,0
            mov innercounter,1
            .while(i<49)
                mov dl,[si+7]
                mov bl,[si+14]
                .if([si]==dl)
                    .if(dl==bl)
                        add score,10
                        mov al,4
                        mov [si],al
                        mov al,6
                        mov [si+7],al
                        mov al,3
                        mov [si+14],al
                    .endif
                .endif
                .if(counter==5)
                    mov si,offset grid
                    mov dx,innercounter
                    add si,dx
                    inc innercounter
                    add i,7
                    mov counter,0
                .endif 
            inc counter
            add si,7
            .endw
            mov dx,score 
            .if(dx==prevscore)
                inc misscounter    
            .endif
            .if(misscounter==3)
                call fail
            .endif
            mov counter,0
            call printgrid
            call printsquare
    .endw


mov colorofgrid,0fh
call printgridlvl2
;;gridlvl2 filling

mov color,2h
mov key,2
call printsquare

mov ax,0 ;reseting mouse
int 33h
mov ax,1;showing mouse
int 33h
mov i, 1
.while(score<50) 
    mov ax,0 ;reseting mouse
    int 33h
    mov ax,1;showing mouse
    int 33h
    mov i, 1
    .while i>0;while 1>0
        mov ax,5 ;click interrupt
        int 33h 
       .if ax==1
            mov ax,3
            mov xcor,cx ; storing x
            mov ycor,dx ; storing y
            int 33h
            jmp start
       .endif 
    .endw
    start:
    call delay
    .while i>0;while 1>0
        mov ax,5 ;click interrupt
        int 33h 
       .if ax==1
            mov ax,3
            mov xcorf,cx ; storing x
            mov ycorf,dx ; storing y
            int 33h
            jmp printcoor
       .endif 
    .endw
    printcoor:
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,xcor
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,ycor
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,xcorf
        call output
        mov dx,32
        mov ah,02h 
        int 21h
        mov ax,ycorf
        call output
        jmp movement
    movement:
;;;;code for finding index of first click
    mov temp,0
    mov reset,0
    mov index1,0
    mov xlow,134
    mov xhigh,164
    mov ylow,54
    mov yhigh,84

    mov ax,xcor
    mov bx,ycor
    .while(temp==0)
        .if (reset==7)
        add ylow,57
        add yhigh,57
        mov xlow,134
        mov xhigh,164
        mov reset,0
        .endif
        .if(ax>xlow)
            .if(ax<xhigh)
                .if(bx>ylow)
                    .if(bx<yhigh)
                        inc temp
                    .endif
                .endif 
            .endif
        .endif 

    add xlow,57
    add xhigh,57
    inc index1
    inc reset
    .endw

    mov dx,32
    mov ah,02h 
    int 21h

    mov ax,index1
    call output
    ;;;;;;;;;;;
    ;code for finding index of second click
    mov temp,0
    mov reset,0
    mov index2,0
    mov xlow,134
    mov xhigh,164
    mov ylow,54
    mov yhigh,84

    mov ax,xcorf
    mov bx,ycorf
    .while(temp==0)
        .if (reset==7)
        add ylow,57
        add yhigh,57
        mov xlow,134
        mov xhigh,164
        mov reset,0
        .endif
        .if(ax>xlow)
            .if(ax<xhigh)
                .if(bx>ylow)
                    .if(bx<yhigh)
                        inc temp
                    .endif
                .endif 
            .endif
        .endif 

    add xlow,57
    add xhigh,57
    inc index2
    inc reset
    .endw

    mov dx,32
    mov ah,02h 
    int 21h

    mov ax,index2
    call output
    ;;;;;;;;;;;;;;;
    ;;;;;;deciding wether to move left right up down
    mov dx,32
    mov ah,02h 
    int 21h

    mov ax,index1
    add ax,1
    mov move,0
    .if(index2==ax)
    ;;right = 1
    mov move,1
    .endif

    mov ax,index2
    add ax,1
    .if(index1==ax)
    ;;left = 2
    mov move,2
    .endif

    mov ax,index2
    add ax,7
    .if(index1==ax)
    ;;up = 3
    mov move,3
    .endif 

    mov ax,index1
    add ax,7
    .if(index2==ax)
    ;;down = 4
    mov move,4
    .endif 
    ;;if none condition met here then just minus the score
    
        mov dx,32
        mov ah,02h
        int 21h
        mov dx,score 
        mov prevscore,dx 
        mov tmmp,0
        mov temp,0
        .if(move!=0)
             mov si,offset gridlvl2
             add si,index1
             sub si,1
             mov dl,[si]
             mov tmmp,dl

             mov si,offset gridlvl2
             add si,index2
             sub si,1
             mov dl,[si]

             mov si,offset gridlvl2
             add si,index1
             sub si,1
             mov [si],dl

             mov si,offset gridlvl2
             add si,index2
             sub si,1
             mov dl,tmmp
             mov [si],dl
        .endif
        mov i,0
        mov si,offset gridlvl2

        mov color,2h
        call printgridlvl2
        call printsquare

        mov si,offset gridlvl2 
        mov i,0
        mov counter,0

        .while(i<49)
            mov dl,[si+1]
            mov bl,[si+2]
            .if([si]==dl)
                .if(dl==bl)
                    add score,10
                    mov al,4
                    mov [si],al
                    mov al,6
                    mov [si+1],al
                    mov al,3
                    mov [si+2],al
                .endif
            .endif
            .if(counter==5)
                add si,2
                add i,2
                mov counter,0
            .endif
        inc i 
        inc counter
        inc si
        .endw

        mov counter,0
        mov si,offset gridlvl2 
        mov i,0
        mov counter,0
        mov innercounter,1
        .while(i<49)
            mov dl,[si+7]
            mov bl,[si+14]
            .if([si]==dl)
                .if(dl==bl)
                    add score,10
                    mov al,4
                    mov [si],al
                    mov al,6
                    mov [si+7],al
                    mov al,3
                    mov [si+14],al
                .endif
            .endif
            .if(counter==5)
                mov si,offset gridlvl2
                mov dx,innercounter
                add si,dx
                inc innercounter
                add i,7
                mov counter,0
            .endif 
        inc counter
        add si,7
        .endw
        mov dx,score 
        .if(dx==prevscore)
            inc misscounter    
        .endif
        .if(misscounter==3)
             call fail
        .endif
        mov counter,0
        call printgridlvl2
        call printsquare
.endw

;call printgridlvl2
;mov key,2
;call printsquare
call delay 
call gameend
;call fail 
exit:
mov ah,4ch 
int 21h
main endp
end main
