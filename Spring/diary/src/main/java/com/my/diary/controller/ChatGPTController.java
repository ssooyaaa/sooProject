package com.my.diary.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.function.BinaryOperator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ChatGPTController {
	
	@RequestMapping(value="/chatGPT", method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public static @ResponseBody String chatGPT(
			@RequestParam String text, HttpServletResponse response) throws Exception {
		
		
		String url = "https://api.openai.com/v1/completions";
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();	
        
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
        con.setRequestProperty("Authorization", "");

        JSONObject data = new JSONObject();
        data.put("model", "text-davinci-003");
        data.put("prompt", text);
        data.put("max_tokens", 4000);
        data.put("temperature", 1.0);

        con.setDoOutput(true);
        con.getOutputStream().write(data.toString().getBytes());

        String output = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8")).lines()
                .reduce(new BinaryOperator<String>() {
					@Override
					public String apply(String a, String b) {
						return a + b;
					}
				}).get();

        String textResponse =  new JSONObject(output).getJSONArray("choices").getJSONObject(0).getString("text");
        
        return textResponse;
    }

    //public static void main(String[] args) throws Exception {
    //    chatGPT("Hello, how are you?");
    //}
}
