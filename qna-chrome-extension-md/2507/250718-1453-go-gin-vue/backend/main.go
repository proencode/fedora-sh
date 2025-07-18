package main

import (
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

// Transaction 구조체 정의
type Transaction struct {
	ID          int       `json:"id"`
	Date        string    `json:"date"`        // YYYY-MM-DD
	Time        string    `json:"time"`        // HH:MM
	Account     string    `json:"account"`     // 거래처
	Item        string    `json:"item"`        // 품목
	Quantity    int       `json:"quantity"`    // 수량
	UnitPrice   int       `json:"unitPrice"`   // 단가
	Amount      int       `json:"amount"`      // 금액 (수량 * 단가)
	Description string    `json:"description"` // 적요
	CreatedAt   time.Time `json:"createdAt"`
	UpdatedAt   time.Time `json:"updatedAt"`
}

var transactions = []Transaction{} // 메모리 내 데이터 저장소
var nextID = 1                     // 다음 트랜잭션 ID

func main() {
	router := gin.Default()

	// CORS 설정: Vue.js 프론트엔드와 통신 허용
	// 실제 배포 시에는 특정 도메인으로 제한하는 것이 좋습니다.
	config := cors.DefaultConfig()
	config.AllowOrigins = []string{"http://localhost:5173"} // Vue 개발 서버 포트
	config.AllowMethods = []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"}
	config.AllowHeaders = []string{"Origin", "Content-Type", "Accept"}
	router.Use(cors.New(config))

	// API 라우트 정의
	router.GET("/api/transactions", getTransactions)
	router.POST("/api/transactions", createTransaction)
	router.GET("/api/transactions/:id", getTransactionByID)
	router.PUT("/api/transactions/:id", updateTransaction)
	router.DELETE("/api/transactions/:id", deleteTransaction)

	log.Println("Gin server running on port 8080")
	router.Run(":8080")
}

// 모든 트랜잭션 조회
func getTransactions(c *gin.Context) {
	c.JSON(http.StatusOK, transactions)
}

// 새 트랜잭션 생성
func createTransaction(c *gin.Context) {
	var newTransaction Transaction
	if err := c.ShouldBindJSON(&newTransaction); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// ID, 금액, 생성/수정 시간 자동 할당
	newTransaction.ID = nextID
	nextID++
	newTransaction.Amount = newTransaction.Quantity * newTransaction.UnitPrice
	newTransaction.CreatedAt = time.Now()
	newTransaction.UpdatedAt = time.Now()

	transactions = append(transactions, newTransaction)
	c.JSON(http.StatusCreated, newTransaction)
}

// 특정 ID의 트랜잭션 조회
func getTransactionByID(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid transaction ID"})
		return
	}

	for _, t := range transactions {
		if t.ID == id {
			c.JSON(http.StatusOK, t)
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Transaction not found"})
}

// 트랜잭션 수정
func updateTransaction(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid transaction ID"})
		return
	}

	var updatedTransaction Transaction
	if err := c.ShouldBindJSON(&updatedTransaction); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	for i, t := range transactions {
		if t.ID == id {
			// ID, 생성 시간은 유지하고 나머지 필드 업데이트
			updatedTransaction.ID = t.ID // ID 유지
			updatedTransaction.CreatedAt = t.CreatedAt // 생성 시간 유지
			updatedTransaction.Amount = updatedTransaction.Quantity * updatedTransaction.UnitPrice // 금액 재계산
			updatedTransaction.UpdatedAt = time.Now() // 수정 시간 업데이트

			transactions[i] = updatedTransaction
			c.JSON(http.StatusOK, updatedTransaction)
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Transaction not found"})
}

// 트랜잭션 삭제
func deleteTransaction(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid transaction ID"})
		return
	}

	for i, t := range transactions {
		if t.ID == id {
			// 해당 인덱스의 트랜잭션 제거
			transactions = append(transactions[:i], transactions[i+1:]...)
			c.JSON(http.StatusNoContent, nil) // 204 No Content
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Transaction not found"})
}
