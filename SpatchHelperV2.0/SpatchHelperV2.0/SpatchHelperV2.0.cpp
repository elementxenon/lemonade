#include <iostream>
#include <string> 
#include <Windows.h> //for windows clipboard interface
/*TODO:
Write actual responses for command items-- mostly done
Write clipboard interface function--not done at all
investigate feasibility-- load commands, responses from external file?
put out fires as needed
possibly make list auto-updating? worth looking into.
*/
using namespace std;


void clip(string s) //windows clipboard interface. DO NOT include for Linux builds
{
	
}

int main()
{
    cout << "SpatchHelper V2.1.0\nWrittem by: ElementXenon\n";
	cout << "Please type a command to output the corresponding spatch dialogue.\n";
	cout << "\nTo use this program, please type a command for dispatch line.\nPlease type 'help' for help. Type 'list' for a list of commands. \n"; //yeah,right. None of this is built yet.
	const int max = 8;

	int i = 0;
	string usrInput = "";
	string command[max] = { "prep","fr","wr","bc","omw","fuel", "help","list" };
	string response[max] =
	{
		"Let me know once you have disabled all modules EXCEPT life support. Also, if you see an oxygen timer at any time, let me know immediatly.\n", //prep text
		"It looks like i have a rat for you :)\n", //fr text
		"Great! Next, i need you to invite your rats to a wing.\n", //wing text
		"Lastly, please light your wing beacon.\n", //bc text
		"Your rats are on their way, and will be with you shortly.\n", //omw text
		"Please stay with your rat(s) for some fuel saving tips and tricks. Thank you for using the fuelrats.\n", //fuel text
		"Sorry,I don't have a helpguide witten yet. Try 'list', and if that does not help you, nep me in #ratchat", //help(less) text
		"List of Commands:\nprep\nfr\nwr\nbc\nlist" //list of commands. May or may not be updated.

	};
	usrInput = "";
	int maxclock = max - 1;
	int run = 1;
	int clock = 0;
	while (run == 1)
	{
		clock = 0;
		cout << "\n>>> ";
		cin >> usrInput;
		i = 0;

		while (i < 1)
		{
			if (usrInput == command[clock])//compare usrInput and command[clock]
			{//true
				i++;
			}
			else if (clock < maxclock)
			{
				clock++;
			}
			else
			{
				cout << "ERROR: RED SIDEWINDER\nSomething went wrong, please try again. If you've seen this more than once, something might be on fire, and you should let someone know.\n";
				run++;
				i++;
			}
		}
		if (run == 1)
		{
			//Following code is for debug and development
			//cout << "Found match in array position" << clock; //debug output (NOT FINAL)
			//cout << "\nChecking response array, position " << clock << " for response..."; // ibid
			//cout << "Found the following response in response array:\n" ; //ibid

			cout << response[clock];

			clip(response[clock]);
			//call the "paste to windows clipboard" function HERE (not built yet) :P
		}
		else if (run /= 1)
		{
			system("pause"); //error state. Not much else to say about this.
			return 0;
		}
	} 

}

