package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

type PaymentResult struct {
	TotalTip int64 `json:"total_tip"`
}

func GetPaymentResult(c echo.Context) error {
	ctx := c.Request().Context()

	var totalTip int64
	if err := dbConn.GetContext(ctx, &totalTip, "SELECT IFNULL(SUM(tip), 0) FROM livecomments"); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "failed to count total tip: "+err.Error())
	}
	
	return c.JSON(http.StatusOK, &PaymentResult{
		TotalTip: totalTip,
	})
}
