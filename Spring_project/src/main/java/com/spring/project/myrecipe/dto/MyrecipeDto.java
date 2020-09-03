package com.spring.project.myrecipe.dto;

public class MyrecipeDto {
	private int num;
	private String title;
	private String subTitle; //서브 타이틀
	private String content;
	private String writer;
	private String regdate;
	private String imagePath; //대표 이미지 경로
	private String showImage; //대표 이미지 실제 이름
	private int viewCount; //조회수
	//페이징 처리를 하기 위한 필드 
	private int startRowNum;
	private int endRowNum;
	//이전 글 다음 글 처리를 위한 필드
	private int prevNum;
	private int nextNum;

	public MyrecipeDto() {}

	public MyrecipeDto(int num, String title, String subTitle, String content, String writer, String regdate,
			String imagePath, String showImage, int viewCount, int startRowNum, int endRowNum, int prevNum,
			int nextNum) {
		super();
		this.num = num;
		this.title = title;
		this.subTitle = subTitle;
		this.content = content;
		this.writer = writer;
		this.regdate = regdate;
		this.imagePath = imagePath;
		this.showImage = showImage;
		this.viewCount = viewCount;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getShowImage() {
		return showImage;
	}

	public void setShowImage(String showImage) {
		this.showImage = showImage;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public int getPrevNum() {
		return prevNum;
	}

	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}

	public int getNextNum() {
		return nextNum;
	}

	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}
}
