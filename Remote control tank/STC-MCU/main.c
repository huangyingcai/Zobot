#include "STC12C5410AD.H"


#define MOVE_FORWARD 1
#define MOVE_BACKWARD 0 

/*
	串口信息开头标识：
	A：左前
	B：左后
	C：右前
	D：右后

	串口信息结束标识：
	Z
*/
#define LEFT_WHEEL_FORWARD 'A'
#define LEFT_WHEEL_BACKWARD 'B'
#define RIGHT_WHEEL_FORWARD 'C'
#define RIGHT_WHEEL_BACKWARD 'D'
#define MESSAGE_END 'Z'


sbit LED = P2 ^ 1;

sbit ENA = P2 ^ 5;
sbit IN1 = P3 ^ 4; 

sbit ENB = P2 ^ 2;
sbit IN4 = P2 ^ 3;
/*
	IN2 : PWM3 P2.4
	IN3 : PWM1 P3.5	
*/

volatile unsigned char _SPEED;
volatile unsigned char _cReceive;
volatile char _pReceive[255];


void InitUART  (void)
{
	//AUXR1 |= 0x80; //切换第二个串口，后期采用STC12C5412AD，使用默认的串口不再切换
	SCON = 0x50;
	TMOD|= 0x20; //定时器1工作方式
	TH1 = 0xFD;
	TL1 = 0xFD;
	TR1 = 1;
	REN = 1;
	ES = 1; //允许串行口中断
	EA = 1; //开启总中断
}


void PWM_INIT (void) {
	CMOD = 0x02;
	CL = 0x00;
	CH = 0x00;
	CCAPM0 = 0x42; 
	CCAP0L = 0x00;
	CCAP0H = 0x00;

	CCAPM1 = 0x42; 
	CCAP1L = 0x00;
	CCAP1H = 0x00;

	CCAPM2 = 0x42; 
	CCAP2L = 0x00;
	CCAP2H = 0x00;

	CCAPM3 = 0x42; 
	CCAP3L = 0x00;
	CCAP3H = 0x00;

	CR = 1;
}

void PWM0_SET (unsigned char a /* 0~255 */) {
	CCAP0L = a;
	CCAP0H = a;
}


void PWM1_SET (unsigned char a /* 0~255 */) {
	CCAP1L = a;
	CCAP1H = a;
}

void PWM2_SET (unsigned char a /* 0~255 */) {
	CCAP2L = a;
	CCAP2H = a;
}

void PWM3_SET (unsigned char a /* 0~255 */) {
	CCAP3L = a;
	CCAP3H = a;
}

void LEFT_WHEEL(unsigned char direction/* 0 ~ 100*/)
{
	ENA = 1;
	if (direction == MOVE_FORWARD)
	{
		IN1 = 1;
		PWM3_SET((unsigned char)(_SPEED / 100.0 * 195 + 60));   //60-255
	} 
	else 
	{
	 	IN1 = 0;
		PWM3_SET(200 - (unsigned char)(_SPEED / 100.0 * 200 ));	//0-200
	}
	
	if (_SPEED == 0) ENA = 0; 
}

void RIGHT_WHEEL(unsigned char direction/* 0 ~ 100 */)
{
	ENB = 1;
 	if (direction == MOVE_FORWARD)
	{
		IN4 = 0;
		PWM1_SET(200 - (unsigned char)(_SPEED / 100.0 * 200 ));	//0-200
		
	}
	else
	{
		IN4 = 1;
		PWM1_SET((unsigned char)(_SPEED / 100.0 * 195 + 60));   //60-255
	}
	if (_SPEED == 0) ENB = 0;
}

void main (void)
{
	InitUART();
	PWM_INIT();

	_cReceive = 0;
	LED = 0;
	_SPEED = 0;
	//PWM0_SET(200);
	//PWM2_SET(255);


	while(1){}
}



void serial_interrupt (void) interrupt 4 using 3
{
	unsigned char i, j, FLAG;


	_pReceive[++_cReceive] = SBUF;
	if (_pReceive[_cReceive] >= 'A' && _pReceive[_cReceive] <= 'D') {
		FLAG = _pReceive[_cReceive];
		_cReceive = 0;	

	}
	
	if (_pReceive[_cReceive] == MESSAGE_END) {
		
		j=1;
		_SPEED = 0;
		for (i = _cReceive - 1; i > 0; i--)
		{
			_SPEED += (_pReceive[i] - '0') * j;
			j *= 10;
		}
	}
	
	 
	RI = 0;
	if (FLAG == LEFT_WHEEL_FORWARD) LEFT_WHEEL(MOVE_FORWARD);
	if (FLAG ==	LEFT_WHEEL_BACKWARD) LEFT_WHEEL(MOVE_BACKWARD);
	if (FLAG == RIGHT_WHEEL_FORWARD) RIGHT_WHEEL(MOVE_FORWARD);
	if (FLAG == RIGHT_WHEEL_BACKWARD) RIGHT_WHEEL(MOVE_BACKWARD);

}
	