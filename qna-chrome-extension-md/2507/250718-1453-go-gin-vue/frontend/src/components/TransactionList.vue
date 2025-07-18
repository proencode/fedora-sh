<template>
  <div>
    <h2>금전출납 내역</h2>
    <button @click="goToAddTransaction">새 거래 추가</button>
    
    <table v-if="transactions.length > 0">
      <thead>
        <tr>
          <th>날짜</th>
          <th>시각</th>
          <th>거래처</th>
          <th>품목</th>
          <th>수량</th>
          <th>단가</th>
          <th>금액</th>
          <th>적요</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="transaction in sortedTransactions" :key="transaction.id">
          <td>{{ transaction.date }}</td>
          <td>{{ transaction.time }}</td>
          <td>{{ transaction.account }}</td>
          <td>{{ transaction.item }}</td>
          <td>{{ transaction.quantity }}</td>
          <td>{{ transaction.unitPrice }}</td>
          <td>{{ transaction.amount.toLocaleString() }}원</td>
          <td>{{ transaction.description }}</td>
          <td>
            <button class="edit-btn" @click="editTransaction(transaction.id)">수정</button>
            <button class="delete-btn" @click="deleteTransaction(transaction.id)">삭제</button>
          </td>
        </tr>
      </tbody>
    </table>
    <p v-else>거래 내역이 없습니다. 새로운 거래를 추가해주세요.</p>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const transactions = ref([]);
const API_URL = 'http://localhost:8080/api/transactions';

// 날짜 기준 내림차순 정렬 (최신순)
const sortedTransactions = computed(() => {
  return [...transactions.value].sort((a, b) => {
    // 날짜를 기준으로 정렬 (YYYY-MM-DD 형식)
    const dateA = new Date(a.date);
    const dateB = new Date(b.date);
    if (dateA.getTime() !== dateB.getTime()) {
      return dateB.getTime() - dateA.getTime();
    }
    // 날짜가 같으면 시간 기준으로 정렬 (HH:MM 형식)
    return b.time.localeCompare(a.time);
  });
});


const fetchTransactions = async () => {
  try {
    const response = await axios.get(API_URL);
    transactions.value = response.data;
  } catch (error) {
    console.error('Error fetching transactions:', error);
  }
};

const goToAddTransaction = () => {
  router.push('/add');
};

const editTransaction = (id) => {
  router.push(`/edit/${id}`);
};

const deleteTransaction = async (id) => {
  if (confirm('정말로 이 거래 내역을 삭제하시겠습니까?')) {
    try {
      await axios.delete(`${API_URL}/${id}`);
      alert('거래 내역이 삭제되었습니다.');
      fetchTransactions(); // 삭제 후 목록 새로고침
    } catch (error) {
      console.error('Error deleting transaction:', error);
      alert('거래 내역 삭제에 실패했습니다.');
    }
  }
};

onMounted(fetchTransactions); // 컴포넌트 마운트 시 데이터 불러오기
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}
th {
  background-color: #f2f2f2;
}
button {
  background-color: #42b983;
  color: white;
  padding: 8px 15px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-bottom: 10px;
}
button:hover {
  background-color: #369c71;
}
.edit-btn {
  background-color: #007bff;
  margin-right: 5px;
}
.edit-btn:hover {
  background-color: #0056b3;
}
.delete-btn {
  background-color: #dc3545;
}
.delete-btn:hover {
  background-color: #c82333;
}
p {
  margin-top: 20px;
  font-style: italic;
  color: #666;
}
</style>
