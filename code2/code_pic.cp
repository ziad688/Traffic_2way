#line 1 "C:/Users/Elsiddiq/Desktop/New folder (2)/code2/code_pic.c"






char counter1=-1;
char counter2=0;
char counter3=0;
char temp=0 ;
char s1=0;
void interrupt()
{
 if(INTF_BIT==1)
 {
 INTF_BIT=0;
 counter1++;
 if(counter3>0){counter1--;}
 }

}
void manual()
{
temp=portd;
while(porta.B4==0)
{
 portb.b1=0;portb.b2=0;
 if(counter1==0)
 {
 portd=0;
  portd.b0 =1;
  portd.B5 =1;
 }
 if(counter1==1)
 {
 portd=0;
  portd.b0 =1;
  portd.b4 =1;
 for(counter3=3;counter3>0;counter3--)
 {
 portb.b1=1;
 portb.b2=1;
 portc=counter3%10+(16*(counter3/10));
 delay_ms(100);
 }
 counter1++;
 }
 if(counter1==2)
 {
 portd=0;
  portd.b3 =1;
  portd.B2 =1;
 }
 if(counter1==3)
 {
 portd=0;
  portd.b1 =1;
  portd.b3 =1;
 for(counter3=3;counter3>0;counter3--)
 {
 portb.b1=1;
 portb.b2=1;
 portc=counter3%10+(16*(counter3/10));
 delay_ms(100);
 }
 counter1++;
 }
 if(counter1==4)
 {
 portd=0;
  portd.b0 =1;
  portd.B5 =1;
 counter1=0;
 }
}
portd=temp;
}
void counter(char c)
{

 portb.b1=1;
 portb.b2=1;
 portc=(c%10+(16*(c/10)));
 if(porta.B4==0){
 manual();
 }
}
void main() {
 ADCON1=0x07;
 trisa.b4=1;
 trisc=0x00;
 portc=0;
 trisb=0;
 portb=0;
 trisd=0;
 portd=0;
 trisb.b0=1;
 INTCON.GIE=1;
 INTCON.INTE=1;
 NOT_RBPU_BIT=0;
 INTEDG_BIT=1;
 while(1)
 {
  portd.b0 =1;
  portd.B5 =1;
 for(counter2=15;counter2>0;counter2--)
 {
 if(counter2==3)
 {
  portd.B5 =0;
  portd.b4 =1;
 }
 counter(counter2);
 delay_ms(100);
 }
  portd.b0 =0;
  portd.B2 =1;
  portd.b4 =0;
  portd.b3 =1;
 for(counter2=23;counter2>0;counter2--)
 {
 if(counter2==3)
 {
  portd.B2 =0;
  portd.b1 =1;
 }
 counter(counter2);
 delay_ms(100);
 }
  portd.b1 =0;
  portd.B5 =0;
  portd.b3 =0;
 }
}
