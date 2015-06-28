require 'Nokogiri'
class Mst < ActiveRecord::Base
	ERRORS = ["Mã xác nhận không đúng. Yêu cầu nhập lại!", "Chứng minh thư/Hộ chiếu không tồn tại trong hệ thống!"]
	class << self
		def fetch_data(cmnd: "", code: "dvgqS")
			url = 'https://www.tncnonline.com.vn/Pages/TracuuMST.aspx'
			uri = URI.parse(url)
			headers = {
	      'Cookie' => 'BIGipServerQTT_HTTP=809648138.20480.0000; ASP.NET_SessionId=fbygib55jeqa5z3k3q5efn55',
				'Origin' => 'https://www.tncnonline.com.vn',
				'Accept-Encoding' => 'gzip, deflate', 
				'Accept-Language' => 'vi,en-US;q=0.8,en;q=0.6,ja;q=0.4',
				'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36',
				'Content-Type' => 'application/x-www-form-urlencoded',
				'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
				'Cache-Control' => 'max-age=0',
				'Referer' => 'https://www.tncnonline.com.vn/Pages/TracuuMST.aspx',
				'Connection' => 'keep-alive',
			}		
			data =  '__SPSCEditMenu=true&MSOWebPartPage_PostbackSource=&MSOTlPn_SelectedWpId=&MSOTlPn_View=0&MSOTlPn_ShowSettings=False&MSOGallery_SelectedLibrary=&MSOGallery_FilterString=&MSOTlPn_Button=none&__EVENTTARGET=&__EVENTARGUMENT=&__REQUESTDIGEST=0x8141C261C838487A1358EC6D1F4CD35ECE394C5AF88B44980D5AFAE2C038C7A0CCF7BD88E4E82525A70A1A7907CEEF1EA8F40551523E35B2C1F3DF7363188227%2C28+Jun+2015+14%3A01%3A37+-0000&MSOAuthoringConsole_FormContext=&MSOAC_EditDuringWorkflow=&MSOSPWebPartManager_DisplayModeName=Browse&MSOWebPartPage_Shared=&MSOLayout_LayoutChanges=&MSOLayout_InDesignMode=&MSOSPWebPartManager_OldDisplayModeName=Browse&MSOSPWebPartManager_StartWebPartEditingName=false&__LASTFOCUS=&__VIEWSTATE=%2FwEPDwUBMA9kFgJmD2QWAgIBD2QWBAIDD2QWAgUmZ19lNDkzNmRhM181M2RkXzRjNzdfYjc2YV9iMDllOWJiZWQzZjYPZBYCZg9kFgQCAQ9kFgJmD2QWAmYPDxYCHgdWaXNpYmxlaGRkAgMPZBYCZg8PFgQeD0hvcml6b250YWxBbGlnbgsqKVN5c3RlbS5XZWIuVUkuV2ViQ29udHJvbHMuSG9yaXpvbnRhbEFsaWduAh4EXyFTQgKAgARkZAIFDxYCHghvbnN1Ym1pdAUZX3NwRm9ybU9uU3VibWl0V3JhcHBlcigpOxYQAgMPPCsADQIADxYGHgtfIURhdGFCb3VuZGceFFN0YXRpY1BvcE91dEltYWdlVXJsBSQvX2xheW91dHMvaW1hZ2VzL2xhcmdlYXJyb3dyaWdodC5naWYeFUR5bmFtaWNQb3BPdXRJbWFnZVVybAUkL19sYXlvdXRzL2ltYWdlcy9sYXJnZWFycm93cmlnaHQuZ2lmZAwUKwACBQMwOjAUKwACFhAeBFRleHQFClBJVCBPbmxpbmUeBVZhbHVlBQpQSVQgT25saW5lHgtOYXZpZ2F0ZVVybAUUL1BhZ2VzL0hvbWVwYWdlLmFzcHgeB0VuYWJsZWRnHgpTZWxlY3RhYmxlZx4IRGF0YVBhdGgFAS8eCURhdGFCb3VuZGceCFNlbGVjdGVkZ2RkAgkPZBYCAgEPFgIfAGgWAmYPZBYEAgIPZBYGAgEPFgIfAGhkAgMPFgIfAGhkAgUPFgIfAGhkAgMPDxYCHglBY2Nlc3NLZXkFAS9kZAIPD2QWAgICDw8WAh8AZxYCHgVzdHlsZQUOZGlzcGxheTpibG9jaztkAhEPZBYCAgEPZBYCZg8PZBYCHgVjbGFzcwUYbXMtc2J0YWJsZSBtcy1zYnRhYmxlLWV4ZAITD2QWAgIDD2QWAgIBDw8WAh8AZ2QWBAIBDw8WAh8AaGQWHAIBDw8WAh8AaGRkAgMPFgIfAGhkAgUPDxYCHwBoZGQCBw8WAh8AaGQCCQ8PFgIfAGhkZAILDw8WAh8AaGRkAg0PDxYCHwBoZGQCDw8PFgQfCmgfAGhkZAIRDw8WAh8AaGRkAhMPDxYEHwpoHwBoZGQCFQ8PFgIfAGhkZAIXDxYCHwBoZAIZDxYCHwBoZAIbDw8WAh8AZ2RkAgMPDxYCHwBnZBYGAgEPDxYCHwBnZGQCAw8PFgYeGHBlcnNpc3RlZEVycm9yQWN0aW9uVHJlZWQeG3BlcnNpc3RlZEVycm9yQWN0aW9uVHJlZUlkc2QfAGdkZAIFDw8WAh8AZ2RkAhUPPCsADQIADxYCHwRnZAwUKwALBScwOjAsMDoxLDA6MiwwOjMsMDo0LDA6NSwwOjYsMDo3LDA6OCwwOjkUKwACFhAfBwULVHJhbmcgY2jhu6cfCAULVHJhbmcgY2jhu6cfCQUUL1BhZ2VzL0hvbWVwYWdlLmFzcHgfCmcfC2cfDAUUL1BhZ2VzL0hvbWVwYWdlLmFzcHgfDWcfDmdkFCsAAhYOHwcFEVbEg24gYuG6o24gdGh14bq%2FHwgFEVbEg24gYuG6o24gdGh14bq%2FHwkFGC9QYWdlcy9UYXhEb2N1bWVudHMuYXNweB8KZx8LZx8MBRgvUGFnZXMvVGF4RG9jdW1lbnRzLmFzcHgfDWdkFCsAAhYOHwcFE03huqt1IGJp4buDdSB0aHXhur8fCAUTTeG6q3UgYmnhu4N1IHRodeG6vx8JBRQvUGFnZXMvVGF4Rm9ybXMuYXNweB8KZx8LZx8MBRQvUGFnZXMvVGF4Rm9ybXMuYXNweB8NZ2QUKwACFg4fBwURxJDEg25nIGvDvSB0aHXhur8fCAURxJDEg25nIGvDvSB0aHXhur8fCQUWL1BhZ2VzL2RhbmdreXRodWUuYXNweB8KZx8LZx8MBRYvUGFnZXMvZGFuZ2t5dGh1ZS5hc3B4Hw1nZBQrAAIWDh8HBRRRdXnhur90IHRvw6FuIHRodeG6vx8IBRRRdXnhur90IHRvw6FuIHRodeG6vx8JBRkvUGFnZXMvcXV5ZXR0b2FudGh1ZS5hc3B4HwpnHwtnHwwFGS9QYWdlcy9xdXlldHRvYW50aHVlLmFzcHgfDWdkFCsAAhYOHwcFFk5nxrDhu51pIHBo4bulIHRodeG7mWMfCAUWTmfGsOG7nWkgcGjhu6UgdGh14buZYx8JBRkvUGFnZXMvTmd1b2lwaHV0aHVvYy5hc3B4HwpnHwtnHwwFGS9QYWdlcy9OZ3VvaXBodXRodW9jLmFzcHgfDWdkFCsAAhYOHwcFCkPDtG5nIGPhu6UfCAUKQ8O0bmcgY%2BG7pR8JBREvUGFnZXMvdG9vbHMuYXNweB8KZx8LZx8MBREvUGFnZXMvdG9vbHMuYXNweB8NZ2QUKwACFg4fBwUNVHJhIGPhu6l1IE1TVB8IBQ1UcmEgY%2BG7qXUgTVNUHwkFFS9QYWdlcy9UcmFjdXVNU1QuYXNweB8KZx8LZx8MBRUvUGFnZXMvVHJhY3V1TVNULmFzcHgfDWdkFCsAAhYOHwcFEkjhu49pIMSRw6FwIHRodeG6vx8IBRJI4buPaSDEkcOhcCB0aHXhur8fCQUQL1BhZ2VzL0ZBUXMuYXNweB8KZx8LZx8MBRAvUGFnZXMvRkFRcy5hc3B4Hw1nZBQrAAIWDh8HBQpMacOqbiBo4buHHwgFCkxpw6puIGjhu4cfCQUTL1BhZ2VzL0NvbnRhY3QuYXNweB8KZx8LZx8MBRMvUGFnZXMvQ29udGFjdC5hc3B4Hw1nZGQCIQ9kFgICAQ88KwANAgAPFgYfBgUkL19sYXlvdXRzL2ltYWdlcy9sYXJnZWFycm93cmlnaHQuZ2lmHwRnHwUFJC9fbGF5b3V0cy9pbWFnZXMvbGFyZ2VhcnJvd3JpZ2h0LmdpZmQMFCsABAULMDowLDA6MSwwOjIUKwACFg4fBwUFTGlzdHMfCAUFTGlzdHMfCQUiL19sYXlvdXRzL3ZpZXdsc3RzLmFzcHg%2FQmFzZVR5cGU9MB8KZx8LZx8MBSIvX2xheW91dHMvdmlld2xzdHMuYXNweD9CYXNlVHlwZT0wHw1nFCsAAgUDMDowFCsAAhYOHwcFBEZBUXMfCAUERkFRcx8JBRkvTGlzdHMvRkFRcy9BbGxJdGVtcy5hc3B4HwpnHwtnHwwFGS9MaXN0cy9GQVFzL0FsbEl0ZW1zLmFzcHgfDWdkFCsAAhYQHwcFC1RyYW5nIGNo4bunHwgFC1RyYW5nIGNo4bunHwkFFC9QYWdlcy9Ib21lcGFnZS5hc3B4HwpnHwtnHwwFFC9QYWdlcy9Ib21lcGFnZS5hc3B4Hw1nHw5nZBQrAAIWDh8HBQlEb2N1bWVudHMfCAUJRG9jdW1lbnRzHwkFIi9fbGF5b3V0cy92aWV3bHN0cy5hc3B4P0Jhc2VUeXBlPTEfCmcfC2cfDAUiL19sYXlvdXRzL3ZpZXdsc3RzLmFzcHg%2FQmFzZVR5cGU9MR8NZxQrAAMFBzA6MCwwOjEUKwACFg4fBwUVVGF4IGRvY3VtZW50cyBsaWJyYXJ5HwgFFVRheCBkb2N1bWVudHMgbGlicmFyeR8JBSovVGF4IGRvY3VtZW50cyBsaWJyYXJ5L0Zvcm1zL0FsbEl0ZW1zLmFzcHgfCmcfC2cfDAUqL1RheCBkb2N1bWVudHMgbGlicmFyeS9Gb3Jtcy9BbGxJdGVtcy5hc3B4Hw1nZBQrAAIWDh8HBRFUYXggRm9ybXMgTGlicmFyeR8IBRFUYXggRm9ybXMgTGlicmFyeR8JBSYvVGF4IEZvcm1zIExpYnJhcnkvRm9ybXMvQWxsSXRlbXMuYXNweB8KZx8LZx8MBSYvVGF4IEZvcm1zIExpYnJhcnkvRm9ybXMvQWxsSXRlbXMuYXNweB8NZ2RkAicPZBYEAgIPZBYCAgMPZBYCZg8PFgIfAGhkZAIED2QWAgIBD2QWAmYPDxYCHwBoZGQYBAUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgMFOGN0bDAwJGN0bDEyJGdfZTQ5MzZkYTNfNTNkZF80Yzc3X2I3NmFfYjA5ZTliYmVkM2Y2JGN0bDQxBThjdGwwMCRjdGwxMiRnX2U0OTM2ZGEzXzUzZGRfNGM3N19iNzZhX2IwOWU5YmJlZDNmNiRjdGw0MgU4Y3RsMDAkY3RsMTIkZ19lNDkzNmRhM181M2RkXzRjNzdfYjc2YV9iMDllOWJiZWQzZjYkY3RsNDIFJmN0bDAwJFBsYWNlSG9sZGVyTGVmdE5hdkJhciRDdXJyZW50TmF2Dw9kBQtUcmFuZyBjaOG7p2QFD2N0bDAwJEdsb2JhbE5hdg8PZAULVHJhbmcgY2jhu6dkBRBjdGwwMCRsb2dvTGlua0lkDw9kBQpQSVQgT25saW5lZGF2ouhB%2Fkp%2Fdzpyruf9scpvw6Qz&__EVENTVALIDATION=%2FwEWBwK5r9CICgL44%2FfqDALF4%2FfqDALilPa5BwK21LHRCgKE6cCuBwKf0vKeCqdmx75Mj8czIuDQVJyJCN9JUMMU&ctl00%24ctl12%24g_e4936da3_53dd_4c77_b76a_b09e9bbed3f6%24LoaiTK=ctl41&ctl00%24ctl12%24g_e4936da3_53dd_4c77_b76a_b09e9bbed3f6%24'
			data += "txtCMT=#{cmnd}"
			data += '&ctl00%24ctl12%24g_e4936da3_53dd_4c77_b76a_b09e9bbed3f6%24'
			data += 'txtSearchMST='
			data += '&ctl00%24ctl12%24g_e4936da3_53dd_4c77_b76a_b09e9bbed3f6%24'
			data += "ctl47=#{code}"
			data += '&ctl00%24ctl12%24g_e4936da3_53dd_4c77_b76a_b09e9bbed3f6%24ctl50=T%C3%ACm+ki%E1%BA%BFm'
			http = Net::HTTP.new uri.host, uri.port
			http.use_ssl = true
  		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			response = http.post uri.path, data, headers
			if response.body
				html = Nokogiri::HTML(response.body)
				case html.css('fieldset table tr span')[0].text
					when ERRORS[0] 
						return { error: 0, message: ERRORS[0] }
					when ERRORS[1] 
						return { error: 1, message: ERRORS[1]  }
					else
						inputs = html.css('fieldset')[1].css('input')
						mst = Mst.create(
							mst: inputs[0].attributes["value"].value,
							ten: inputs[1].attributes["value"].value,
							cmnd: inputs[2].attributes["value"].value,
							noicutru: inputs[3].attributes["value"] ? inputs[3].attributes["value"].value : "",
							ngaycap: inputs[4].attributes["value"].value,
							noicap: inputs[6].attributes["value"].value,
						)
						return { data: mst }
				end
				return { error: 2, message: html.css('fieldset table tr span')[0].text}
			end
		rescue
			nil
		end
	end
end
