package com.qst.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * @ClassName:VarifyCodeController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/5/31 15:31
 **/
@Controller
public class VerifyCodeController {

    @RequestMapping("getVerifyCode")
    public void getVerifyCode(HttpSession session, HttpServletResponse response) throws IOException {

        //图片对象
        BufferedImage bi = new BufferedImage(80,35,BufferedImage.TYPE_INT_RGB);

        //画笔
        Graphics2D g = (Graphics2D) bi.getGraphics();

        //设置画笔的颜色
        g.setColor(Color.white);

        //填充背景
        g.fillRect(0,0,80,35);

        //设置画笔为蓝色
        g.setColor(Color.blue);

        //产生验证码，四位
        String str = "23456789abcdefghkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ";

        StringBuilder s = new StringBuilder();

        for (int i = 0; i < 4; i++) {

            //产生随机的下标
            int index = new Random().nextInt(str.length());//nextInt范围[0,1)

            String randomChar = str.charAt(index)+"";

            s.append(randomChar);

        }

        g.drawString(s.toString(),25,20);

        session.setAttribute("verifyCode",s.toString());

        ImageIO.write(bi,"JPEG",response.getOutputStream());

    }
}
