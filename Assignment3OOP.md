Six Combinations of Access Modifiers in C#:

public: Accessible from any part of the program.
private: Accessible only within the class or struct where it is declared.
protected: Accessible within its class and by derived class instances.
internal: Accessible within the same assembly, but not from another assembly.
protected internal: Accessible within its assembly or from derived classes.
private protected: Accessible within its class or in derived classes located in the same assembly.
Difference Between static, const, and readonly:

static: Belongs to the type itself rather than to any instance. It can be accessed without creating an instance of the class.
const: Indicates that the value is constant and cannot be changed after compilation. It's a compile-time constant.
readonly: Indicates that the field can only be assigned during initialization or in a constructor of the same class.
What Does a Constructor Do?

A constructor is a special method of a class or structure that initializes new instances of that class or structure. It prepares the new object for use, often accepting parameters that it uses to set member variables.
Why Is the partial Keyword Useful?

The partial keyword allows the definition of a class, struct, or interface to be split into multiple files. It is useful for managing large projects, working with automatically generated code, or keeping separately generated components of a class separate.
What Is a Tuple?

A tuple is a data structure that provides an easy way to represent a single set of data composed of multiple values, possibly of different types. In C#, tuples are immutable and can be used to return multiple values from a method without using out parameters or creating a class/struct.
What Does the record Keyword Do?

The record keyword in C# defines a reference type that provides built-in functionality for encapsulating data. Records are intended for immutable data models and provide value-based equality checks and other benefits over traditional classes.
Overloading vs. Overriding:

Overloading means having multiple methods in the same scope, with the same name but different parameters. It's a form of compile-time polymorphism.
Overriding is a feature that allows a subclass or child class to provide a specific implementation of a method that is already provided by one of its super-classes or parent classes.
Difference Between a Field and a Property:

A field is a variable of any type that is declared directly in a class or struct.
A property is a member that provides a flexible mechanism to read, write, or compute the value of a private field. Properties can have get and set methods, which allow for more complex operations than fields.
Making a Method Parameter Optional:

You can make a method parameter optional by specifying a default value for it in the method declaration. If the caller doesn't provide a value, the default value is used.
Interface vs. Abstract Class:

An interface defines a contract that can be implemented by classes and structs. An interface can contain methods, properties, events, and indexers, but no implementation.
An abstract class can contain both abstract methods (without an implementation) and methods with implementation. A class that inherits an abstract class must implement all its abstract methods.
Accessibility Level of Members of an Interface:

Members of an interface are implicitly public because the purpose of an interface is to define a contract that implementing classes must follow.
Polymorphism allows derived classes to provide different implementations of the same method. True.

The override keyword is used to indicate that a method in a derived class is providing its own implementation of a method. True.

The new keyword is used to indicate that a method in a derived class is providing its own implementation of a method. True, but it specifically indicates hiding a base class member rather than overriding it.

Abstract methods can be used in a normal (non-abstract) class. False.

Normal (non-abstract) methods can be used in an abstract class. True.

Derived classes can override methods that were virtual in the base class. True.

Derived classes can override methods that were abstract in the base class. True.

In a derived class, you can override a method that was neither virtual nor abstract in the base class. False.

A class that implements an interface does not have to provide an implementation for all of the members of the interface. False.

A class that implements an interface is allowed to have other members that aren’t defined in the interface. True.

A class can have more than one base class. False. C# does not support multiple inheritance for classes.

A class can implement more than one interface. True.

## Work With Method

1. 

```c#
using System;

class Program
{
    static void Main(string[] args)
    {
        int[] numbers = GenerateNumbers(10); // Generates an array of 10 numbers. You can change the size by passing a different value.
        Reverse(numbers);
        PrintNumbers(numbers);
    }

    // Generates an array of sequential numbers of the specified length.
    static int[] GenerateNumbers(int length)
    {
        int[] numbers = new int[length];
        for (int i = 0; i < length; i++)
        {
            numbers[i] = i + 1;
        }
        return numbers;
    }

    // Reverses the elements of the given array in place.
    static void Reverse(int[] numbers)
    {
        int temp;
        for (int i = 0; i < numbers.Length / 2; i++)
        {
            // Swap the elements
            temp = numbers[i];
            numbers[i] = numbers[numbers.Length - i - 1];
            numbers[numbers.Length - i - 1] = temp;
        }
    }

    // Prints the elements of the given array.
    static void PrintNumbers(int[] numbers)
    {
        foreach (int number in numbers)
        {
            Console.WriteLine(number);
        }
    }
}

```

2. 
```C#

using System;

class Program
{
    static void Main(string[] args)
    {
        for (int i = 1; i <= 10; i++)
        {
            Console.WriteLine(Fibonacci(i));
        }
    }

    static int Fibonacci(int n)
    {
        // Base case: the first two numbers in the sequence are 1.
        if (n <= 2)
        {
            return 1;
        }
        // Recursive case: the sum of the two preceding numbers.
        else
        {
            return Fibonacci(n - 1) + Fibonacci(n - 2);
        }
    }
}
```

## Designing and Building Classes using object-oriented principles

```c#
public abstract class Person
{
    public string Name { get; set; }
    private DateTime birthDate;

    protected Person(string name, DateTime birthDate)
    {
        this.Name = name;
        this.birthDate = birthDate;
    }

    public int Age
    {
        get { return DateTime.Now.Year - birthDate.Year; }
    }

    public virtual string GetInfo()
    {
        return $"Name: {Name}, Age: {Age}";
    }
}

public class Student : Person
{
    public string Major { get; set; }

    public Student(string name, DateTime birthDate, string major) 
        : base(name, birthDate)
    {
        this.Major = major;
    }

    public override string GetInfo()
    {
        return base.GetInfo() + $", Major: {Major}";
    }
}

public class Instructor : Person
{
    public decimal Salary { get; private set; }

    public Instructor(string name, DateTime birthDate, decimal salary) 
        : base(name, birthDate)
    {
        this.Salary = salary;
    }

    public override string GetInfo()
    {
        return base.GetInfo() + $", Salary: {Salary:C}";
    }

    public virtual void CalculateSalary(int hoursWorked, decimal hourlyRate)
    {
        Salary = hoursWorked * hourlyRate;
    }
}

using System;

class Program
{
    static void Main(string[] args)
    {
        Student student = new Student("John Doe", new DateTime(2000, 4, 25), "Computer Science");
        Instructor instructor = new Instructor("Jane Smith", new DateTime(1980, 7, 15), 50000);
        
        Console.WriteLine(student.GetInfo());
        Console.WriteLine(instructor.GetInfo());
        
        instructor.CalculateSalary(160, 30);
        Console.WriteLine($"After calculating: {instructor.GetInfo()}");
    }
}
```

```c#
public interface IPersonService
{
    string GetInfo();
    void AddAddress(string address);
    List<string> GetAddresses();
}

public interface IStudentService : IPersonService
{
    void EnrollInCourse(Course course);
    void CalculateGPA();
}

public interface IInstructorService : IPersonService
{
    void CalculateBonus();
}

public interface ICourseService
{
    void EnrollStudent(Student student);
}

public interface IDepartmentService
{
    void AssignHead(Instructor head);
    void AddCourse(Course course);
}

public abstract class Person : IPersonService
{
    public string Name { get; set; }
    protected DateTime BirthDate;
    private List<string> addresses = new List<string>();

    public Person(string name, DateTime birthDate)
    {
        Name = name;
        BirthDate = birthDate;
    }

    public int CalculateAge() => DateTime.Now.Year - BirthDate.Year;

    public virtual string GetInfo() => $"Name: {Name}, Age: {CalculateAge()}";

    public void AddAddress(string address) => addresses.Add(address);

    public List<string> GetAddresses() => addresses;
}
public class Instructor : Person, IInstructorService
{
    public Department Department { get; set; }
    public DateTime JoinDate { get; set; }
    private decimal salary;

    public decimal Salary
    {
        get { return salary; }
        set { salary = value >= 0 ? value : throw new ArgumentException("Salary cannot be negative."); }
    }

    public Instructor(string name, DateTime birthDate, decimal salary, DateTime joinDate)
        : base(name, birthDate)
    {
        Salary = salary;
        JoinDate = joinDate;
    }

    public int YearsOfExperience => DateTime.Now.Year - JoinDate.Year;

    public void CalculateBonus()
    {
        Salary += YearsOfExperience * 1000; 
    }

    public override string GetInfo()
    {
        return $"{base.GetInfo()}, Salary: {Salary:C}, Dept: {Department?.Name}";
    }
}

public class Student : Person, IStudentService
{
    private List<Course> courses = new List<Course>();
    private Dictionary<Course, char> grades = new Dictionary<Course, char>();

    public Student(string name, DateTime birthDate) : base(name, birthDate) { }

    public void EnrollInCourse(Course course)
    {
        if (!courses.Contains(course))
        {
            courses.Add(course);
            course.EnrollStudent(this);
        }
    }

    public void AssignGrade(Course course, char grade)
    {
        if (courses.Contains(course))
        {
            grades[course] = grade;
        }
    }

    public void CalculateGPA()
    {
        double totalPoints = 0;
        foreach (var grade in grades.Values)
        {
            totalPoints += grade switch
            {
                'A' => 4,
                'B' => 3,
                'C' => 2,
                'D' => 1,
                _ => 0,
            };
        }
        double gpa = grades.Count > 0 ? totalPoints / grades.Count : 0;
        Console.WriteLine($"{Name}'s GPA: {gpa:N2}");
    }

    public override string GetInfo()
    {
        return base.GetInfo() + $", Enrolled Courses: {courses.Count}";
    }
}
public class Course : ICourseService
{
    public string Name { get; set; }
    private List<Student> enrolledStudents = new List<Student>();

    public Course(string name)
    {
        Name = name;
    }

    public void EnrollStudent(Student student)
    {
        if (!enrolledStudents.Contains(student))
        {
            enrolledStudents.Add(student);
        }
    }

    public void PrintEnrolledStudents()
    {
        Console.WriteLine($"Course: {Name}");
        foreach (var student in enrolledStudents)
        {
            Console.WriteLine(student.Name);
        }
    }
}
public class Department : IDepartmentService
{
    public string Name { get; set; }
    public Instructor Head { get; private set; }
    public decimal Budget { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    private List<Course> courses = new List<Course>();

    public Department(string name, decimal budget, DateTime startDate, DateTime endDate)
    {
        Name = name;
        Budget = budget;
        StartDate = startDate;
        EndDate = endDate;
    }

    public void AssignHead(Instructor head)
    {
        Head = head;
        head.Department = this;
    }

    public void AddCourse(Course course)
    {
        if (!courses.Contains(course))
        {
            courses.Add(course);
        }
    }

    public void PrintDepartmentInfo()
    {
        Console.WriteLine($"Department: {Name}, Head: {Head.Name}, Budget: {Budget:C}, Courses Offered: {courses.Count}");
    }
}
class Program
{
    static void Main(string[] args)
    {
        Department compSci = new Department("Computer Science", 1000000, DateTime.Now.AddYears(-1), DateTime.Now);
        Instructor profSmith = new Instructor("Jane Smith", new DateTime(1980, 7, 15), 70000, new DateTime(2010, 8, 23));
        compSci.AssignHead(profSmith);

        Student johnDoe = new Student("John Doe", new DateTime(2000, 4, 25));
        Course programming101 = new Course("Programming 101");
        compSci.AddCourse(programming101);

        johnDoe.EnrollInCourse(programming101);
        johnDoe.AssignGrade(programming101, 'A');
        johnDoe.CalculateGPA();

        Console.WriteLine(profSmith.GetInfo());
        Console.WriteLine(johnDoe.GetInfo());
        programming101.PrintEnrolledStudents();
        compSci.PrintDepartmentInfo();
    }
}
```

```c#
public class Color
{
    public int Red { get; set; }
    public int Green { get; set; }
    public int Blue { get; set; }
    public int Alpha { get; set; }

    public Color(int red, int green, int blue, int alpha)
    {
        Red = red;
        Green = green;
        Blue = blue;
        Alpha = alpha;
    }

    public Color(int red, int green, int blue) : this(red, green, blue, 255) { }

    public int GetGrayscaleValue()
    {
        return (Red + Green + Blue) / 3;
    }
}

public class Ball
{
    public int Size { get; private set; }
    public Color Color { get; set; }
    private int throwCount = 0;

    public Ball(Color color, int size)
    {
        Color = color;
        Size = size;
    }

    public void Pop()
    {
        Size = 0;
    }

    public void Throw()
    {
        if (Size > 0)
        {
            throwCount++;
        }
    }

    public int GetThrowCount()
    {
        return throwCount;
    }
}

class Program
{
    static void Main(string[] args)
    {

        Color redColor = new Color(255, 0, 0);
        Color blueColor = new Color(0, 0, 255);


        Ball redBall = new Ball(redColor, 10);
        Ball blueBall = new Ball(blueColor, 15);

        redBall.Throw();
        redBall.Throw();
        blueBall.Throw();


        Console.WriteLine($"Red Ball thrown: {redBall.GetThrowCount()} times");
        Console.WriteLine($"Blue Ball thrown: {blueBall.GetThrowCount()} times");


        redBall.Pop();
        redBall.Throw(); 

        Console.WriteLine($"After popping, Red Ball thrown: {redBall.GetThrowCount()} times");
        Console.WriteLine($"Blue Ball thrown: {blueBall.GetThrowCount()} times");
    }
}


```




