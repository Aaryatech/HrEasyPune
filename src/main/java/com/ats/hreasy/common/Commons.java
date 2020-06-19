package com.ats.hreasy.common;

import org.springframework.context.annotation.Scope;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.ats.hreasy.model.Info;

@Scope("session")
public class Commons {
	
	public static Info saveAssetLog(int assetId,String assetLogDesc,int assetTransId,
			int loginUserId) {
		
		Info info=new Info();
		
		try {
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("assetId", assetId);
			map.add("assetLogDesc", assetLogDesc);
			map.add("assetTransId", assetTransId);
			map.add("loginUserId", loginUserId);
			
			 info = Constants.getRestTemplate()
					.postForObject(Constants.url + "/saveAssetLog", map, Info.class);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return info;
		
	}
}
