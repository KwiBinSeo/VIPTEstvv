// 작업에 대한 모든 내용을 저장하는 객체

package com.cglab.smartplace;

import java.util.ArrayList;

public class AllData {
	
	// 로그인한 회원 정보를 저장할 변수들
	public static String name = "";
	public static String position = "";
	public static String management_area = "";
	public static String area_number = "";
	
	
	public static String yesterday_date = ""; // 전일 작업 일
	public static String yesterday_issue = ""; // 전일 작업 사항
	public static String today_issue = ""; // 금일 작업 사항
	public static String today_weather = ""; // 오늘 날씨
	public static String yesterday_weather = ""; // 어제 날씨
	
	public static int equipment_count = 5; // 장비 투입 현황 동적 표 할당을 위해 라인 수를 저장 할 변수
	public static int occupation_count = 5; // 인원 투입 현황 동적 표 할당을 위해 라인 수를 저장 할 변수
	
	// 공종 작업 현황 관련 변수들
	public static int construction_list_count = 0; // 공종 작업 현황 라인 수를 저장 할 변수 선언
	
	public static ArrayList<String> construction = new ArrayList<String>();
	public static ArrayList<String> construction_number = new ArrayList<String>();
	public static ArrayList<String> total = new ArrayList<String>();
	public static ArrayList<String> today_result = new ArrayList<String>();
	public static ArrayList<String> accumulate = new ArrayList<String>();
	
	// 인원 현황 저장 변수
	public static ArrayList<String> occupation = new ArrayList<String>();
	public static ArrayList<String> occupation_yesterday = new ArrayList<String>();
	public static ArrayList<String> occupation_today = new ArrayList<String>();
	public static ArrayList<String> occupation_total = new ArrayList<String>();
	
	// 장비 투입 현황 저장 변수
	public static ArrayList<String> equipment = new ArrayList<String>();
	public static ArrayList<String> equipment_yesterday = new ArrayList<String>();
	public static ArrayList<String> equipment_today = new ArrayList<String>();
	public static ArrayList<String> equipment_total = new ArrayList<String>();
	
	// 자재 투입 현황 저장 변수
	public static int materials_list_count = 0; // 자재 투입 현황 라인 수를 저장 할 변수 선언
	
	public static ArrayList<String> materials = new ArrayList<String>(); // 자재명을 저장할 ArrayList
	public static ArrayList<String> materials_type = new ArrayList<String>(); // 자재 타입(관급/사급)을 저장할 ArrayList
	public static ArrayList<String> materials_total = new ArrayList<String>(); // 자재 별 설계량 저장할 ArrayList
	public static ArrayList<String> materials_base_quantity = new ArrayList<String>(); // 자재 별 기반입량을 저장할 ArrayList
	public static ArrayList<String> materials_input_quantity = new ArrayList<String>(); // 자재 별 반입량을 저장할 ArrayList
	public static ArrayList<String> materials_total_quantity = new ArrayList<String>(); // 자재 별 반입 누계를 저장할 ArrayList
	public static ArrayList<String> materials_etc = new ArrayList<String>(); // 자재 별 비고를 저장할 ArrayList
	
	
}
