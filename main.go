package main

import (
	"fmt"
	"log/slog"
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	//_, trusted, _ := net.ParseCIDR("127.0.0.1/32")
	//e.IPExtractor = echo.ExtractIPFromRealIPHeader(
	//	echo.TrustIPRange(trusted),
	//)

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, fmt.Sprintf("RemoteAddr: %s\nReal IP: %s\n", c.Request().RemoteAddr, c.RealIP()))
	})

	if err := e.Start(":8080"); err != nil {
		slog.Error("start server error: %v", err)
	}
}
