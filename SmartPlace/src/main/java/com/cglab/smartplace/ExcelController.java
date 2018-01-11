package com.cglab.smartplace;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Servlet implementation class ExcelController
 */
public class ExcelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	public String User_ID = "master";
	public String today = toDay();
	public String yesterday = yesterDay();
	public ArrayList<String> yesterday_issue_array = new ArrayList<String>();
	public String yesterday_issue = "";
	public ArrayList<String> today_issue_array = new ArrayList<String>();
	public String today_issue = "";
	public String area = "순천향대학교 멀티미디어관 화장실 보수 작업";
	public String weather = "맑음";
	
	// 공종 데이터
	public ArrayList<String> construction = new ArrayList<String>();
	public ArrayList<String> construction_unit = new ArrayList<String>();
	public ArrayList<String> construction_total = new ArrayList<String>();
	public ArrayList<String> construction_today_result = new ArrayList<String>();
	public ArrayList<String> construction_accumulate = new ArrayList<String>();
	public ArrayList<Row> row_con = new ArrayList<Row>();
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public ExcelController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

		// 작업 일지 채우기
		for(int i = 0; i < 10; i++) {
			yesterday_issue_array.add("- 어제 작업사항 : "+i);
			today_issue_array.add("- 오늘 작업사항 : "+i);
		}
		
		// 공종 데이터 넣기
		for(int i = 0; i < 10; i++) {
			construction.add("공종 작업 " + i);
		}
		// 공종 단위
		for(int i = 0; i < 10; i++) {
			construction_unit.add("개수");
		}
		// 공종 설계량
		for(int i = 0; i < 10; i++) {
			construction_total.add("1000");
		}
		// 공종 실적
		for(int i = 0; i < 10; i++) {
			construction_today_result.add("500");
		}
		// 누계 실적
		for(int i = 0; i < 10; i++) {
			construction_accumulate.add("700");
		}
		
        try {
            // 엑셀파일
            File file = new File("D:/temp.xlsx");
 
            // 엑셀 파일 오픈
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));
            Workbook xlsxWb = wb;//new XSSFWorkbook(); // Excel 2007 이상
       
            // 시트 선택
            Sheet sheet1 = xlsxWb.getSheet("sheet");
            
            // 공사명 입력
            Row row0_0 = sheet1.getRow(3); // 4(행)
            Cell cell0_0 = row0_0.getCell(2); // C
            cell0_0.setCellValue(area);
            
            // 일자 입력
            Row row0_1 = sheet1.getRow(2); // 3행
            Cell cell0_1 = row0_1.getCell(10); // K
            cell0_1.setCellValue(today); 
                        
            // 날씨 입력
            Row row0_2 = sheet1.getRow(3); // 4행
            Cell cell0_2 = row0_2.getCell(10); // K
            cell0_2.setCellValue(weather); 
            
            // 전일 날짜 입력
            Row row1 = sheet1.getRow(5); // 6(행)
            Cell cell1 = row1.getCell(6); // G
            cell1.setCellValue(yesterday);
            
            // 금일 날짜 입력 
            Row row2 = sheet1.getRow(5); // 6(행)
            Cell cell2 = row2.getCell(12); // M
            cell2.setCellValue(today);
            
            // 전일 작업사항 입력
            Row row3 = sheet1.getRow(6);
            Cell cell3 = row3.getCell(2);
                      for(int i = 0; i < yesterday_issue_array.size(); i++) {
            	yesterday_issue = yesterday_issue + yesterday_issue_array.get(i) + "\n";
            }    
            cell3.setCellValue(yesterday_issue);
            
            // 금일 작업사항 입력
            Row row4 = sheet1.getRow(6);
            Cell cell4 = row4.getCell(8);
                      for(int i = 0; i < today_issue_array.size(); i++) {
            	today_issue = today_issue + today_issue_array.get(i) + "\n";
            }    
            cell4.setCellValue(today_issue);
            
            // 공종 데이터 넣기
            for(int i = 0; i < construction.size(); i++) {
            	if(i < 8) {
	            	Row row5_0 = sheet1.getRow(34+i); // 35(행)    
	                Cell cell5_0 = row5_0.getCell(1); // B
	                cell5_0.setCellValue(construction.get(i));
                }
            	else {
	            	Row row5_0 = sheet1.getRow(34+i-8); // 35(행)    
	                Cell cell5_0 = row5_0.getCell(8); // B -> I로 증가
	                cell5_0.setCellValue(construction.get(i));
                }
            }
            
            // 공종 단위 넣기
            for(int i = 0; i < construction_unit.size(); i++) {
            	if(i < 8) {
	            	Row row5_1 = sheet1.getRow(34+i); // 35(행)    
	                Cell cell5_1 = row5_1.getCell(3); // D
	                cell5_1.setCellValue(construction_unit.get(i));
                }
            	else {
	            	Row row5_1 = sheet1.getRow(34+i-8); // 35(행)    
	                Cell cell5_1 = row5_1.getCell(10); // D -> K로 증가
	                cell5_1.setCellValue(construction_unit.get(i));
                }
            }
            
            // 공종 설계량 넣기
            for(int i = 0; i < construction_total.size(); i++) {
            	if(i < 8) {
	            	Row row5_1 = sheet1.getRow(34+i); // 35(행)    
	                Cell cell5_1 = row5_1.getCell(4); // E
	                cell5_1.setCellValue(construction_total.get(i));
                }
            	else {
	            	Row row5_1 = sheet1.getRow(34+i-8); // 35(행)    
	                Cell cell5_1 = row5_1.getCell(11); // E -> L로 증가
	                cell5_1.setCellValue(construction_total.get(i));
                }
            }

            
            System.out.println(today);
            
            File Copy_File = new File("D:/"+User_ID+today+".xlsx");
            FileOutputStream fileOut = new FileOutputStream(Copy_File);
            xlsxWb.write(fileOut);
            
        } catch (FileNotFoundException fe) {
            System.out.println("FileNotFoundException >> " + fe.toString());
        } catch (IOException ie) {
            System.out.println("IOException >> " + ie.toString());
        }
    }
	
	// 오늘 날짜 검출 메소드
	public String toDay() {
		//서버 날짜 date에 저장
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(Calendar.DATE, 0); // 금일 날짜 가져오기

		// 금일 요일 계산하는 부분
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int date = calendar.get(Calendar.DATE);
		
		String today = Integer.toString(year) +"-"+ Integer.toString(month) +"-"+ Integer.toString(date); // 오늘 날짜
		
		return today;
	}
	
	// 어제 날짜 검출 메소드
	public String yesterDay() {
		//서버 날짜 date에 저장
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.add(Calendar.DATE, -1); // 금일 날짜 가져오기

		// 금일 요일 계산하는 부분
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int date = calendar.get(Calendar.DATE);
		
		String yesterday = Integer.toString(year) +"-"+ Integer.toString(month) +"-"+ Integer.toString(date); // 오늘 날짜
		
		return yesterday;
	}
}
