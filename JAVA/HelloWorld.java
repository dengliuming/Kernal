enum color{
    red{
        public void display() {
            System.out.println("red------"+"红色");
        }
    },
    blue{
        public void display() {
            System.out.println("blue------"+"蓝色");
        }
    },
    whilt{
        public void display() {
            System.out.println("whilt------"+"白色");
        }
    },
    blank
    {
        public void display() {
            System.out.println("blank------"+"黑色");
        }
    },
    pink{
        public void display() {
            System.out.println("pink------"+"粉红色");
        }
    };
    private  color() {
        
        System.out.println("独属于color的构造方法！");
    }
    public void checkInfo() {
        System.out.println("该枚举类的类型为："+color.class);
    }
    public abstract void display();
}
public class HelloWorld {
    public static void main(String[] args) {
        
        color test=color.blue;
        test.checkInfo();
        test.display();
        System.out.println("遍历枚举的值");
        for (color temp : color.values()) {
            temp.display();
        }
        
    }
}