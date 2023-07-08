// See https://aka.ms/new-console-template for more inform
using System;

namespace C_sharpTest // Note: actual namespace depends on the project name.
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        	Person p = new Person("Name");
		
	}
    }
    public class Person{
	    string name;
	public Person(string name){
		this.name = name;
	}
	public string GetName(){return name;}
	public void SetName(string name){
		this.name = name;
	}
    }
}
