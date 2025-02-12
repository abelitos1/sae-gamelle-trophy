/******************* BIBLIOTHEQUES *******************************************/


/*faire le switch case, avec tout les virages et la ligne droite*/

#include "nboard.h"

/******************* CONSTANTES SYMBOLIQUES **********************************/

#define BP0 GPIO_read(PA_9)
#define BP1 GPIO_read(PA_10)
#define BP2 GPIO_read(PB_0)
#define NUM0 GPIO_read(PB_6)
#define NUM1 GPIO_read(PB_7)

#define LED0 PB_3
#define LED1 PA_7
#define LED2 PA_6
#define LED3 PA_5
#define LED4 PA_3
#define LED5 PA_1
#define LED6 PA_0


/******************* PROTOTYPES DE FONCTIONS *********************************/

void state (void);
int CNYread (void);

int read (void);
/******************* PROGRAMME PRINCIPAL *************************************/

int main(void)
{
	// Initialisation de variables locales
	uint16_t CNY1;
	uint16_t CNY2;
	uint16_t CNY3;
	uint16_t CNY4;
	uint16_t CNY5;





	// Initialisation de la carte
	NB_init();

	float MOT_D=0.00 ;
	float MOT_G=0.00 ;


	IHM_LCD_clear();
	IHM_LCD_locate(0, 0);

	NB_ADC_MUX_select(0);

	while (1)
	{

		state ();
		CNYread();
		TIM_wait_ms(100);

		//
		//		if (BP2==0){
		//			seuil-=100;
		//		}



		//		if(NUM1==0){
		//			GPIO_write (LED5,1) ;
		//		}
		//		else{
		//			GPIO_write (LED5,0) ;
		//		}




	}



	//
}

void state (void)
{
	typedef enum {depart,devant,stop} type_state;
	static type_state state = depart;
	float MOT_D=0.00 ;
	float MOT_G=0.00 ;
	switch (state)
	{
		case depart:



			MOT_D=0.00 ;
			MOT_G=0.00 ;

			PWM_write(PB_5,MOT_D);
			PWM_write(PB_4,MOT_G);

			if(NUM0==0)
			{

				IHM_LCD_locate(0, 0);
				IHM_LCD_printf("GO GO GO");
				GPIO_write (LED6,1) ;
				state = devant;
			}

			else
			{
				GPIO_write (LED6,0) ;
			}

			break;


		case devant:

			IHM_LCD_clear();
			IHM_LCD_locate(0, 0);
			IHM_LCD_printf("devant");

			MOT_D=0.600 ;
			MOT_G=0.840 ;

			PWM_write(PB_5,MOT_D);
			PWM_write(PB_4,MOT_G);

			if(NUM1==1
					){
				state = stop;
			}

			break;

		case stop:

			IHM_LCD_clear();
			IHM_LCD_locate(0, 0);
			IHM_LCD_printf("STOOOP");

			MOT_D=0.00 ;
			MOT_G=0.00 ;

			PWM_write(PB_5,MOT_D);
			PWM_write(PB_4,MOT_G);

			break;

	}
}

int CNYread(void)
{

	int CNY1,CNY2,CNY3,CNY4,CNY5;
	int seuil = 2000;
			NB_ADC_MUX_select(0);
			CNY1=NB_ADC_read(PB_1);


			if(CNY1<seuil){
				GPIO_write (LED0,1) ;
			}
			else{
				GPIO_write (LED0,0) ;
			}

			NB_ADC_MUX_select(1);
			CNY2=NB_ADC_read(PB_1);
			IHM_LCD_locate(0, 6);
			IHM_LCD_printf("%4d", CNY2);

			if(CNY2<seuil){
				GPIO_write (LED1,1) ;
			}
			else{
				GPIO_write (LED1,0) ;
			}

			NB_ADC_MUX_select(2);
			CNY3=NB_ADC_read(PB_1);
			IHM_LCD_locate(0,12);
			IHM_LCD_printf("%4d", CNY3);

			if(CNY3<seuil){
				GPIO_write (LED2,1) ;
			}
			else{
				GPIO_write (LED2,0) ;
			}

			NB_ADC_MUX_select(3);
			CNY4=NB_ADC_read(PB_1);
			IHM_LCD_locate(1, 0);
			IHM_LCD_printf("%4d", CNY4);

			if(CNY4<seuil){
				GPIO_write (LED3,1) ;
			}
			else{
				GPIO_write (LED3,0) ;
			}

			NB_ADC_MUX_select(4);
			CNY5=NB_ADC_read(PB_1);
			IHM_LCD_locate(1, 6);
			IHM_LCD_printf("%4d", CNY5);

			if(CNY5<seuil){
				GPIO_write (LED4,1) ;
			}
			else{
				GPIO_write (LED4,0) ;
			}

			return CNY1,CNY2,CNY3,CNY4,CNY5;
}

//int read (void)
//{
//
//}

/* Fonction inversion LED ****************************************************/

