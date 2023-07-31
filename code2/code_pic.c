#define red1 portd.b0
#define yellow1 portd.b1
#define green1 portd.B2
#define red2 portd.b3
#define yellow2 portd.b4
#define green2 portd.B5
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
           red1=1;
           green2=1;
      }
      if(counter1==1)
      {
           portd=0;
           red1=1;
           yellow2=1;
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
           red2=1;
           green1=1;
      }
      if(counter1==3)
      {
           portd=0;
           yellow1=1;
           red2=1;
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
           red1=1;
           green2=1;
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
                   red1=1;
                   green2=1;
                   for(counter2=15;counter2>0;counter2--)
                   {
                         if(counter2==3)
                         {
                          green2=0;
                          yellow2=1;
                         }
                         counter(counter2);
                         delay_ms(100);
                   }
                   red1=0;
                   green1=1;
                   yellow2=0;
                   red2=1;
                   for(counter2=23;counter2>0;counter2--)
                   {
                         if(counter2==3)
                         {
                           green1=0;
                           yellow1=1;
                         }
                         counter(counter2);
                         delay_ms(100);
                  }
                  yellow1=0;
                  green2=0;
                  red2=0;
  }
}