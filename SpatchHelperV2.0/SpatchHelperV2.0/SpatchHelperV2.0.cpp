// SpatchHelperV2.0.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <string> 
#include <Windows.h> //for windows clipboard interface
/*TODO:
Write actual responses for command items
Write clipboard interface function
investigate feasibility-- load commands, responses from external file?
put out fires as needed
*/
using namespace std;


void clip(string s) //windows clipboard interface. DO NOT include for Linux builds
{
	
}

int main()
{
    cout << "SpatchHelper V2.1.0\nWrittem by: ElementXenon\n";
	cout << "Please type a command to output the corresponding spatch dialogue.\n";
	cout << "Type 'help' for the help page, and 'list' for a listing of commands.\n"; //yeah,right. None of this is built yet.
	const int max = 8;

	int i = 0;
	string usrInput = "";
	string command[max] = { "prep","fr","wr","bc","omw","fuel", "help","list" };
	string response[max] =
	{
		"prep text",
		"fr text",
		"wr text",
		"bc text",
		"omw text",
		"fuel+ text",
		"Sorry,I don't have a helpguide witten yet. Try 'list', and if that does not help you, nep me in #ratchat",
		"List of Commands:\nprep\nfr\nwr\nbc\nlist"

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
				cout << "ERROR: RED SIDEWINDER\nSomething went wrong, please try again. If you've seen this more than once, something might be on fire, and you should let someone know.";
				run++;
				i++;
			}
		}
		if (run == 1)
		{
			cout << "Found match in array position" << clock; //debug output (NOT FINAL)
			cout << "\nChecking response array, position " << clock << " for response..."; // ibid
			cout << "Found the following response in response array:\n" << response[clock]; //ibid

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

