<template>
  <div>
    <h2>{{ isEditMode ? '거래 수정' : '새 거래 추가' }}</h2>
    <form @submit.prevent="saveTransaction">
      <div class="form-group">
        <label for="date">날짜:</label>
        <input type="date" id="date" v-model="transaction.date" required />
      </div>
      <div class="form-group">
        <label for="time">시각:</label>
        <input type="time" id="time" v-model="transaction.time" required />
      </div>
      <div class="form-group">
        <label for="account">거래처:</label>
        <input type="text" id="account" v-model="transaction.account" placeholder="거래처 입력" required />
      </div>
      <div class="form-group">
        <label for="item">품목:</label>
        <input type="text" id="item" v-model="transaction.item" placeholder="품목 입력" required />
      </div>
      <div class="form-group">
        <label for="quantity">수량:</label>
        <input type="number" id="quantity" v-model.number="transaction.quantity" required />
      </div>
      <div class="form-group">
        <label for="unitPrice">단가:</label>
        <input type="number" id="unitPrice" v-model.number="transaction.unitPrice" required />
      </div>
      <div class="form-group">
        <label for="amount">금액:</label>
        <input type="number" id="amount" :value="calculatedAmount" readonly />
      </div>
      <div class="form-group">
        <label for="description">적요:</label>
        <textarea id="description" v-model="transaction.description" placeholder="적요 입력"></textarea>
      </div>
      <button type="submit">{{ isEditMode ? '수정 완료' : '추가' }}</button>
      <button type="button" @click="cancel">취소</button>
    </form>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const route = useRoute();
const API_URL = 'http://localhost:8080/api/transactions';

const transaction = ref({
  id: null,
  date: '',
  time: '',
  account: '',
  item: '',
  quantity: 0,
  unitPrice: 0,
  amount: 0, // 금액은 백엔드에서 계산하므로 초기값 0
  description: ''
});

const isEditMode = computed(() => route.params.id != null);

// 금액 자동 계산 (프론트엔드에서 단순 표시용)
const calculatedAmount = computed(() => {
  return transaction.value.quantity * transaction.value.unitPrice;
});

onMounted(async () => {
  if (isEditMode.value) {
    try {
      const response = await axios.get(`${API_URL}/${route.params.id}`);
      // 백엔드에서 받은 데이터를 폼에 채웁니다.
      // Date와 Time은 백엔드에서 string으로 오므로 그대로 사용합니다.
      transaction.value = response.data;
    } catch (error) {
      console.error('Error fetching transaction:', error);
      alert('거래 내역을 불러오는 데 실패했습니다.');
      router.push('/'); // 실패 시 목록 페이지로 리다이렉트
    }
  } else {
    // 새 거래 추가 모드일 경우, 현재 날짜와 시간으로 기본값 설정
    const now = new Date();
    transaction.value.date = now.toISOString().split('T')[0]; // YYYY-MM-DD
    transaction.value.time = now.toTimeString().split(' ')[0].substring(0, 5); // HH:MM
  }
});

const saveTransaction = async () => {
  try {
    if (isEditMode.value) {
      await axios.put(`${API_URL}/${transaction.value.id}`, transaction.value);
      alert('거래 내역이 수정되었습니다.');
    } else {
      await axios.post(API_URL, transaction.value);
      alert('새 거래 내역이 추가되었습니다.');
    }
    router.push('/'); // 저장 후 목록 페이지로 이동
  } catch (error) {
    console.error('Error saving transaction:', error);
    alert('거래 내역 저장에 실패했습니다.');
  }
};

const cancel = () => {
  router.push('/'); // 취소 시 목록 페이지로 이동
};
</script>

<style scoped>
.form-group {
  margin-bottom: 15px;
  text-align: left;
}
.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}
.form-group input[type="text"],
.form-group input[type="date"],
.form-group input[type="time"],
.form-group input[type="number"],
.form-group textarea {
  width: calc(100% - 20px);
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
.form-group textarea {
  resize: vertical;
  min-height: 80px;
}
button {
  background-color: #42b983;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 10px;
}
button:hover {
  background-color: #369c71;
}
button[type="button"] { /* 취소 버튼 스타일 */
  background-color: #6c757d;
}
button[type="button"]:hover {
  background-color: #5a6268;
}
</style>
