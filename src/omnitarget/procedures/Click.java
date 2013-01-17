/* This file is part of VoltDB.
 * Copyright (C) 2008-2012 VoltDB Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */


//
// Accepts a vote, enforcing business logic: make sure the vote is for a valid
// contestant and that the voter (phone number of the caller) is not above the
// number of allowed votes.
//

package omnitarget.procedures;

import org.voltdb.ProcInfo;
import org.voltdb.SQLStmt;
import org.voltdb.VoltProcedure;
import org.voltdb.VoltTable;

import java.util.Date;
import java.util.Calendar;

@ProcInfo (
    partitionInfo = "click.offer_id:0",
    singlePartition = true
)
public class Click extends VoltProcedure {

    // potential return codes
    public static final long CLICK_SUCCESSFUL = 0;
    
    // Records a click
    public final SQLStmt insertClickStmt = new SQLStmt(
            "INSERT INTO click (transaction_id, click_date, click_date_interval, is_unique, offer_id, aff_id, url_id, finance_rule_id, ad_id, campaign_id, creative_id, placement_id, dma, city, state, zip, country, latitude, longitude, image, text, dynamic_location_text, source, sub1, sub2, sub3, sub4, sub5, cost, revenue, referrer, browser, os, ip) \
				VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");

    public long run(String transaction_id, int is_unique, int offer_id, int aff_id, int url_id, int finance_rule_id, int ad_id, int campaign_id, int creative_id, int placement_id, int dma, String city, String state
		, String zip, String country, float latitude, float longitude, String image, String text, String dynamic_location_text, String source, String sub1, String sub2, String sub3, String sub4, String sub5
		, float cost, float revenue, String referrer, String browser, String os, String ip) {

		Date click_date = VoltProcedure.getTransactionTime();
		Date click_date_interval = Calendar.set(click_date.getYear(), click_date.getMonth(), click_date.getHourOfDay(), 0);
		
        // Post the vote
        voltQueueSQL(insertClickStmt, EXPECT_SCALAR_MATCH(1), transaction_id, click_date, click_date_interval, is_unique, offer_id, aff_id, url_id, finance_rule_id, ad_id, campaign_id, creative_id, placement_id, dma, city, state, zip, country, latitude, longitude, image, text, dynamic_location_text, source, sub1, sub2, sub3, sub4, sub5, cost, revenue, referrer, browser, os, ip);
        voltExecuteSQL(true);

        // Set the return value to 0: successful vote
        return CLICK_SUCCESSFUL;
    }
}
