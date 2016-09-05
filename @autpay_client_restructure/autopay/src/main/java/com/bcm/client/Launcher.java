package com.bcm.client;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.bcm.client.autopay.collection.*;
import javax.swing.*;

public class Launcher {
  public static void main(String[] args) {
    ApplicationContext context = new ClassPathXmlApplicationContext("SpringBeans.xml");
    HelloWorld obj1 = (HelloWorld) context.getBean("helloBean");
    obj1.printHello();
    JFrame obj2 = (CollectionScreen) context.getBean("screenBean");
    obj2.setVisible(true);
  }
}
